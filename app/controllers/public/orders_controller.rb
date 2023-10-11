class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def thanks
  end

  def create
    @orders = Order.new(order_params)
    @orders.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @orders.save
    @cart_items.each do |cart_item|
        order_detail = OrderDetail.new()
        order_detail.order_id = @orders.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.save
        cart_item.delete
    end

    redirect_to public_orders_thanks_path
  end

  def index
    @orders= current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :price, :postage, :id)
  end
end
