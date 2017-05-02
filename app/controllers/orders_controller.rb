class OrdersController < ApplicationController
  before_action :set_restaurant
  before_action :set_restaurant_order, only: [:show, :update, :destroy]

  def index
    json_response(@restaurant.orders)
  end

  def create
    @restaurant_order = @restaurant.orders.create!(menu_category_params)
    json_response(@restaurant_order, :created)
  end

  def show
    json_response(@restaurant_order)
  end

  def update
    @restaurant_order.update(menu_category_params)
    head :no_content
  end

  def destroy
    @restaurant_order.destroy
    head :no_content
  end

  private

  def menu_category_params
    params.permit(:status, { :items_list => [] }, :table_id)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_restaurant_order
    @restaurant_order = @restaurant.orders.find_by!(id: params[:id]) if @restaurant
  end
end
