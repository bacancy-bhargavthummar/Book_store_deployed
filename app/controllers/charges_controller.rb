# frozen_string_literal: true

class ChargesController < ApplicationController

  before_action :authenticate_user!

  def order_placed
    @cart = Cart.find(params[:id])
    @cart.update(delivery_address: params[:delivery_address])
    session[:this_cart] = @cart.id
  end

  def get_pdf
    @cart = Cart.find(params[:id])
    respond_to do |format|
      format.pdf do
        render pdf: 'Invoice',
               template: 'charges/invoice'
      end
    end
  end

  def create
    @cart = Cart.find(session[:this_cart].to_i)

    @amount = session[:grand_total]
    @amount = @amount.to_i

    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })

    charge = Stripe::Charge.create({
                                     customer: customer.id,
                                     amount: @amount * 100,
                                     description: 'Rails Stripe customer',
                                     currency: 'inr'
                                   })

    # @lineItems_for = LineItem.where(cart_id: @cart.id)
    @cart.line_items.each do |l|
      @fetched_book = Book.find(l.book_id)
      next unless @fetched_book.total_qty >= l.quantity.to_i

      @fetched_book.total_qty -= l.quantity.to_i
      @fetched_book.selling_quantity += l.quantity.to_i
      @fetched_book.update(total_qty: @fetched_book.total_qty, selling_quantity: @fetched_book.selling_quantity)
    end
    @cart.save
    @cart.update(status: true)

    session[:cart_id] = nil
    session[:this_cart] = nil

    InvoiceMailer.bill(@cart).deliver_now
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

end
