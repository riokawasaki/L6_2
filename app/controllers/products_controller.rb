class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = '商品を追加しました'
      redirect_to products_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    
    CartItem.where(product_id: product.id).destroy_all
    
    if product.destroy
      redirect_to products_path, notice: '商品が削除されました。'
    else
      redirect_to products_path, notice: '商品が削除されませんでした。'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
