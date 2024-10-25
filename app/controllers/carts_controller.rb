class CartsController < ApplicationController
  def show
    # CartItemを直接取得し、必要な属性を確保
    @cartitems = CartItem.where(cart_id: current_cart.id).includes(:product)
  end
end
