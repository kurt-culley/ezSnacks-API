class OrderItemsController < ApplicationController

  before_action :set_order
  before_action :set_order_item, only: [:show, :destroy, :add_quantity, :reduce_quantity]

  def index
    if @order.order_items.length > 0
      json_response(@order.order_items)
    else
      head :no_content
    end
  end

  def create
    @menu_item = MenuItem.find(order_item_params[:menu_item_id])
    if @order.menu_items.include?(@menu_item)
      @order_item = @order.order_items.find_by(:menu_item_id => @menu_item)
      @order_item.quantity += 1
      @order_item.save!
      head :no_content
    else
      @order_item = @order.order_items.create!(order_item_params)
      json_response(@order_item, :created)
    end
  end

  def show
    json_response(@order_item)
  end

  def destroy
    @order_item.destroy
    head :no_content
  end

  def add_quantity
    @order_item.quantity += 1
    @order_item.save
    json_response(@order_item, :created)
  end

  def reduce_quantity
    @order_item.quantity -= 1
    if @order_item.quantity == 0
      @order_item.delete
    else
      @order_item.save
    end
    json_response(@order_item, :created)
  end

  private

  def order_item_params
    params.permit(:quantity, :menu_item_id)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_order_item
    @order_item = @order.order_items.find_by!(id: params[:id]) if @order
  end

end
