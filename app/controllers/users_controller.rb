# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user
  before_action :set_user, only: %i[show pending_requests approved_requests rejected_requests individual_uploads]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user

  def index
    @user = User.ransack(params[:q])
    @users_result = @user.result(distinct: true).paginate(per_page: 5, page: params[:page])
  end

  def show; end
  
  def seller
    @book_seller = if params[:query].present?
                    BookSeller.finding(params[:query])
                   else
                    BookSeller.all
                   end
    @sellers = @book_seller.select(:seller_id).distinct
    @book_seller = @book_seller.paginate(per_page: 5, page: params[:page])
  end
  
  def all_pending_requests
    @carts = Cart.where('approval = ? AND status = ?', 0, true).order(id: :desc)
  end
  
  def pending_requests
    @carts = Cart.where('user_id = ? AND approval = ? AND status = ?', @user.id, 0, true).order(id: :desc)
  end

  def approved_requests
    @carts = Cart.where('user_id = ? AND approval = ? ', @user.id, 1).order(id: :desc)
  end
  
  def rejected_requests
    @carts = Cart.where('user_id = ? AND approval = ? ', @user.id, 2).order(id: :desc)
  end
  
  def individual_uploads
    books = BookSeller.where('seller_id = ?', @user.id).pluck(:book_id)
    
    if (params[:min_date] && params[:max_date]).present?
      books_graph = Book.user_uploads_params_graph(params, @user)
      @book_id_array = []
      @book_qty_array = []
      @book_hash = Hash.new

      books_graph.each {|id, qty| @book_id_array.push(id); @book_qty_array.push(qty) }
      @book_name = Book.where(id: [@book_id_array]).pluck(:name)
      @book_name.each_with_index {|k,i| @book_hash[k] = @book_qty_array[i]}
      @book_hash
    else 
      @book_hash = Book.joins(:book_sellers).where('book_sellers.seller_id = ?', @user.id).pluck('name, selling_quantity')
    end 
    
    @books_result = Book.where(id: [books]).paginate(per_page: 3, page: params[:page])
  end

  def destroy
    user = User.find(params[:user_id])
    @books = BookSeller.select(:book_id).where(seller_id: user.id)

    @books.each do |b|
      book = Book.find(b.book_id)
      book.destroy
    end

    redirect_to '/users' if user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def check_user
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def invalid_user
    redirect_to root_path
  end
end
