class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :set_categories
  # before_action :authenticate_user!,except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    @book.user_id = current_user.id
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    #@book = current_user.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

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

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :image, :author, :synopsis, :published_on,:category_id,:user_id)
    end
    def set_categories
      @categories = Category.all.order(:name)
    end

    # private

    # # def authenticate_user!
    # #   unless current_user
    # #     redirect_to new_user_session_path, alert: 'You need to sign in first.'
    # #   end
    # # end
  
    # def current_user
    #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # end
end
