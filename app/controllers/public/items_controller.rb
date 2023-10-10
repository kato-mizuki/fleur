class Public::ItemsController < ApplicationController
  def index
    @item = Item.page(params[:page]).per(8)
    @item.count
  end

  def show
    @items = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :price)
  end


end
