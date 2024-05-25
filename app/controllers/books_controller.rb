class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_categories
  before_action :set_storage
  # before_action :authenticate_user!,except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /books or /books.json
  def index
    #@books = Book.all
    @storage = Storage.find(params[:storage_id])
    # params[:tag] ? @books = Book.tagged_with(params[:tag]) : @books = Book.all
    if params[:tag]
      @books = @storage.books.tagged_with(params[:tag])
    else
      @books = @storage.books
    end
  end

  def search
    if params.dig(:title_search).present?
      @books = Book.filter_by_title(params[:title_search]).order(created_at: :desc)
    else
      @books = []
    end
    respond_to do |format|
      format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("search_results",
            partial: "books/search_results",
            locals: { books: @books })
          ]
      end
    end
  end




  def show 
    @storage = Storage.find(params[:storage_id])
    @book = Book.find(params[:id])
    @comments = @book.comments.order(created_at: :desc)
    @custom_fields = @book.item_custom_vals
  end

  # GET /books/new
  def new
    @storage = Storage.find(params[:storage_id])
    @book = @storage.books.new
    @book.user_id = current_user.id
    @custom_fields = @storage.custom_fielders 
  end

  # GET /books/1/edit
  def edit
    @custom_fields = @book.storage.custom_fielders
  end

  # POST /books or /books.json
  # def create
  #   #@book = Book.new(book_params)
  #   #@book = current_user.books.build(book_params)
  #   @storage = Storage.find(params[:storage_id])
  #   @book = @storage.books.new(book_params.merge(user_id: current_user.id))

  #   respond_to do |format|
  #     if @book.save
  #       # create_item_custom_vals(@book, params[:custom_fields])
  #       format.html { redirect_to storage_book_path(@storage, @book), notice: "Book was successfully created." }
  #       format.json { render :show, status: :created, location: @book }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @book.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /books/1 or /books/1.json
  # def update
  #   respond_to do |format|
  #     if @book.update(book_params)
  #       # update_item_custom_vals(@book, params[:custom_fields])
  #       format.html { redirect_to storage_book_path(@storage, @book), notice: "Book was successfully updated." }
  #       format.json { render :show, status: :ok, location: @book }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @book.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @storage = Storage.find(params[:storage_id])
    @book = @storage.books.new(book_params.merge(user_id: current_user.id))
   
    respond_to do |format|
      if @book.save
        create_item_custom_vals(@book, params[:custom_fields])
        format.html { redirect_to storage_book_path(@storage, @book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        @custom_fields = @storage.custom_fielders
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        update_item_custom_vals(@book, params[:custom_fields])
        format.html { redirect_to storage_book_path(@storage, @book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        @custom_fields = @book.storage.custom_fielders
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    #@book.destroy!#tagging add korar age chilo
    @book = Book.find(params[:id])
    @book.taggings.destroy_all
    @book.item_custom_vals.destroy_all
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end
    def set_storage
      @storage = Storage.find(params[:storage_id])
    end

  

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :image, :author, :synopsis, :published_on,:category_id,:user_id,:storage_id,tag_ids: [])
    end
    def set_categories
      @categories = Category.all.order(:name)
    end
    def create_item_custom_vals(book, custom_fields)
      return unless custom_fields
      custom_fields.each do |custom_fielder_id, field_value|
        book.item_custom_vals.create(custom_fielder_id: custom_fielder_id, field_value: field_value)
      end
    end
  
    def update_item_custom_vals(book, custom_fields)
      return unless custom_fields
      book.item_custom_vals.destroy_all
      custom_fields.each do |custom_fielder_id, field_value|
        book.item_custom_vals.create(custom_fielder_id: custom_fielder_id, field_value: field_value)
      end
    end
    
end
