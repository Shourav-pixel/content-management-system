class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book
    def create
        @book = Book.find(params[:book_id])
        @comment = @book.comments.create(comment_params)
        @comment.user = current_user
        if @comment.save
            flash[:notice] = "Comment created"
            redirect_to book_path(@book)
        else
            flash[:alert] = "Comment not created"
            redirect_to book_path(@book)
        end
    end
    def destroy
        @comment = @book.comments.find(params[:id])
        @comment.destroy
        redirect_to book_path(@book)
    end

    private

    def set_book
        @book = Book.find(params[:book_id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

end
