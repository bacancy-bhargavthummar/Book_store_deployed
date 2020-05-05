# frozen_string_literal: true

class StoreController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_input

  def index
    if params[:query].present?
      @books = Book.searching(params[:query]).paginate(page: params[:page], per_page: 4)
    else
      @books = Book.all.paginate(page: params[:page], per_page: 4)
    end
    @categories = Category.all
    
    respond_to do |format|
      format.html
      format.js
     end
  end

  def category_filter
    @books = Book.where(category_id: params[:id]).paginate(page: params[:page], per_page: 4)
  end

  private

  def invalid_input
    redirect_to root_path
  end
end
