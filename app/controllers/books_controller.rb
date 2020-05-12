# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_book, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_book

  def index
    # @book = Book.ransack(params[:q])
    # @books_result = @book.result(distinct: true)
    if params[:query].present?
      @books_result = Book.searching(params[:query]).paginate(per_page: 5, page: params[:page])
    else
      @books_result = Book.all.paginate(per_page: 5, page: params[:page])
    end
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit
    unless Book.validate_user(@book,current_user).present?
      redirect_to root_path
    end
  end

  def create
    check_book = Book.joins(:book_sellers).find_by(['books.isbn = ? AND book_sellers.seller_id = ?', book_params[:isbn], current_user.id])
    if check_book.present?
      check_book.total_qty += book_params[:total_qty].to_i
      check_book.update(total_qty: check_book.total_qty)
      redirect_to root_path
    else
      @book = Book.new(book_params)
      respond_to do |format|
        if @book.save
          @book_seller = BookSeller.new(seller_id: current_user.id, book_id: @book.id)
          @book_seller.save
          format.html { redirect_to book_path(@book, @book_seller), notice: 'Book was successfully created.' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_path(@book, @book_seller), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
    @book_seller = BookSeller.find_by(book: @book)
  end

  def book_params
    params.require(:book).permit(:name, :description, :author, :price, :total_qty, :isbn, :category_id, :image)
  end

  def invalid_book
    # logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path
  end
end
