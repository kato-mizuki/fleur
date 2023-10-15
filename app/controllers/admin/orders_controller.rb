class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.find(params[:id])
  end
end
