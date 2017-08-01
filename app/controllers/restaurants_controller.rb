class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.all
    if @restaurants.length > 0
      json_response(@restaurants)
    else
      head :no_content
    end
  end

  def create
    @restaurant = Restaurant.create!(restaurant_params)
    json_response(@restaurant, :created)
  end

  def show
    json_response(@restaurant)
  end

  def update
    @restaurant.update(restaurant_params)
    head :no_content
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  def orders
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.orders.length > 0
      json_response(@restaurant.orders)
    else
      head :no_content
    end
  end

  private

    def restaurant_params
      params.permit(:name)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end
end
