class PagesController < ApplicationController
  def home
    @books = Book.all.order(created_at: :desc).limit(20)
    @storages = Storage.all.order(created_at: :desc).limit(20)
    #@tags = Tag.all
    @categories = Category.all
  end

  def profile
    @storage = Storage.all
    @user = User.find(current_user.id)
    
  end
end
