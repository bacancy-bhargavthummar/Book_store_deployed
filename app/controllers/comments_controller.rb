# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comment

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @book
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = @book.comments.find(params[:id])
    @comment.destroy
    @book
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def invalid_comment
    redirect_to root_path
  end
end
