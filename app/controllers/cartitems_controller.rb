class CartitemsController < ApplicationController
  def new
    @cart_item = CartItem.new
    @product = Product.find(params[:product_id]) # 商品情報を取得
  end

  def create
    @cart_item = CartItem.new(product_id: params[:cart_item][:product_id],
                               cart_id: current_cart.id, 
                               qty: params[:cart_item][:qty])
    if @cart_item.save
      flash[:notice] = 'カートに商品を追加しました'
      redirect_to root_path
    else
      flash.now[:alert] = 'カートに商品を追加できませんでした。'
      @product = Product.find(params[:cart_item][:product_id]) # エラー時に商品情報を再取得
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    qty_to_remove = params[:qty].to_i

    if qty_to_remove >= cart_item.qty
      # 指定数量がカートアイテムの数量以上の場合、アイテムを完全に削除
      cart_item.destroy
      flash[:notice] = 'カートから商品が削除されました。'
    else
      # 指定数量分だけ減らす
      cart_item.update(qty: cart_item.qty - qty_to_remove)
      flash[:notice] = "#{qty_to_remove} 個の #{cart_item.product.name} をカートから削除しました。"
    end

    redirect_to cart_path(current_cart.id)
  end
end
