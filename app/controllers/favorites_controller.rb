# frozen_string_literal: true

class FavoritesController < ApplicationController

  before_action :authenticate_user!
  before_action :check_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_faverite

  def index
    @favorite_books = current_user.books
  end

  def create_destroy
    favorite = Favorite.find_or_initialize_by(user: current_user, book_id: params[:format] )
    if !favorite.persisted?
      favorite.save
    else
      favorite.destroy
    end
    redirect_to book_path(params[:format])
  end

  private

  def check_user
    unless current_user.id == params[:user_id].to_i
      redirect_to root_path
    end
  end

  def invalid_faverite
    redirect_to root_path
  end
end