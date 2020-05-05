# frozen_string_literal: true

module CurrentCart

  private
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create(user_id: current_user.id)
    # @cart.user_id = current_user.id can not be worked
    session[:cart_id] = @cart.id
  end
end
