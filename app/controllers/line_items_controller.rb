# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :authenticate_user!

  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: %i[destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_line_item

  def create
    book = Book.find(params[:book_id])
    qty = params[:qty]
    @line_item = @cart.add_product(book, qty)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart }
        format.json { render :show, status: :created, location: @line_item }
        # format.js
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def invalid_line_item
    # logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path
  end
end
