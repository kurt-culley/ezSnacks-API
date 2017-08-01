class OrdersController < ApplicationController

  before_action :set_table, only: [:index, :create]
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    if @table.orders.length > 0
      json_response(@table.orders)
    else
      head :no_content
    end
  end

  def create
    @restaurant_order = @table.orders.create!(order_params)
    json_response(@restaurant_order, :created)
  end

  def show
    json_response(@order)
  end

  def update
    @order.update(order_params)
    head :no_content
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def order_params
    params.permit(:status, { :items_list => [] }, :table_id)
  end

  def set_table
    @table = Table.find(params[:table_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
