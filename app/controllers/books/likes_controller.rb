class Books::LikesController < ApplicationController
    include ActionView::RecordIdentifier
    before_action :authenticate_user!
    before_action :set_book
 def update 
    if @book.liked_by?(current_user)
        @book.unlike(current_user)
    else
        @book.like(current_user)
    end
    respond_to do |format|
        format.turbo_stream{
            render turbo_stream: turbo_stream.replace(dom_id(@book, :likes),partial: "books/likes", locals: {book: @book})
        }
    end
 end
 def set_book
    @book = Book.find(params[:book_id])

 end

end
