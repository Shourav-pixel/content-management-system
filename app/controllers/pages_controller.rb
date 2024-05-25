class PagesController < ApplicationController
  def home
    @books = Book.all.order(created_at: :desc).limit(20)
    @storages = Storage.all.order(created_at: :desc).limit(20)
  end
end
