class StoragesController < ApplicationController
  before_action :set_storage, only: %i[ show edit update destroy ]
  before_action :set_categories, only: %i[ new edit create update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /storages or /storages.json
  def index
    @storages = Storage.all
  end

  # GET /storages/1 or /storages/1.json
  def show
  end

  # GET /storages/new
  def new
    @storage = Storage.new
    @storage.custom_fielders.build
    #@storage.user_id = current_user.id
  end

  # GET /storages/1/edit
  def edit
  end

  # POST /storages or /storages.json
  def create
    @storage = Storage.new(storage_params)

    respond_to do |format|
      if @storage.save
        format.html { redirect_to storage_url(@storage), notice: "Storage was successfully created." }
        format.json { render :show, status: :created, location: @storage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storages/1 or /storages/1.json
  def update
    respond_to do |format|
      if @storage.update(storage_params)
        format.html { redirect_to storage_url(@storage), notice: "Storage was successfully updated." }
        format.json { render :show, status: :ok, location: @storage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storages/1 or /storages/1.json
  def destroy
    @storage = Storage.find(params[:id])
    @storage.custom_fielders.destroy_all

    respond_to do |format|
      format.html { redirect_to storages_url, notice: "Storage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_storage
      @storage = Storage.find(params[:id])
    end

    def set_categories
      @categories = Category.all.order(:name)
    end

    # Only allow a list of trusted parameters through.
    def storage_params
      params.require(:storage).permit(:name, :description, :image, :user_id, :category_id, custom_fielders_attributes: [:id, :field_name, :field_type, :state, :_destroy])
    end
  
    # def authenticate_user!
    #   unless current_user
    #     redirect_to new_user_session_path, alert: 'You need to sign in first.'
    #   end
    # end
    
    # def current_user
    #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # end
end
