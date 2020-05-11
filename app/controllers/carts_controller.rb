# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: %i[show destroy do_approve resume_cart]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    unless (current_user.admin? || @cart.user_id == current_user.id).present?
      redirect_to root_path
    end
  end

  def your_carts
    @carts = Cart.includes(:line_items).where(user_id: current_user.id).order(id: :desc)  
    # @line_items_of_carts = LineItem.where(cart_id: @carts.ids)
  end

  def resume_cart
    session[:cart_id] = @cart.id
    redirect_to @cart, notice: "Your cart of #{@cart.id} is resumed."
  end

  def do_approve
    @cart.update(approval: 1)
    InvoiceMailer.bill(@cart).deliver_now

    redirect_to all_pending_requests_user_path, notice: 'Order is Approve'
  end

  def do_reject
    @cart = Cart.find(params[:invoice_id])
    @cart.update(notice: params[:notice])

    @cart.line_items.each do |l|
      @fetched_book = Book.find(l.book_id)
      @fetched_book.total_qty += l.quantity.to_i
      @fetched_book.selling_quantity -= l.quantity.to_i
      @fetched_book.update(total_qty: @fetched_book.total_qty, selling_quantity: @fetched_book.selling_quantity)
    end
    @cart.update(approval: 2)
    InvoiceMailer.bill(@cart).deliver_now
    redirect_to all_pending_requests_user_path, notice: 'Order is Rejected.'
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Your cart is currently empty !' }
      format.json { head :no_content }
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def invalid_cart
    redirect_to root_path
  end
end
