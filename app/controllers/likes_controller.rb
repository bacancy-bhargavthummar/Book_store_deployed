# frozen_string_literal: true

class LikesController < ApplicationController

  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_like

  def create
    @like = Like.new
    @like.comment_id = params[:comment_id]
    @like.user_id = current_user.id
    if @like.save
      @book = Book.find(params[:book_id])
    else
      redirect_to book_path(params[:book_id]), notice: 'Disliked Failed'
    end
  end

  def destroy
    like = Like.find(params[:id])
    if like.destroy
      @book = Book.find(params[:book_id])
    else
      redirect_to book_path(params[:book_id]), notice: 'Disliked Failed'
    end
  end

  private

  def invalid_like
    redirect_to root_path
  end
end

