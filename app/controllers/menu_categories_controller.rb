class MenuCategoriesController < ApplicationController

  before_action :set_restaurant
  before_action :set_restaurant_menu_category, only: [:show, :update, :destroy]

  def index
    json_response(@restaurant.menu_categories)
  end

  def create
    @restaurant_menu_category = @restaurant.menu_categories.create!(menu_category_params)
    json_response(@restaurant_menu_category, :created)
  end

  def show
    json_response(@restaurant_menu_category)
  end

  def update
    @restaurant_menu_category.update(menu_category_params)
    head :no_content
  end

  def destroy
    @restaurant_menu_category.destroy
    head :no_content
  end

  private

    def menu_category_params
      params.permit(:name, :image_url)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_restaurant_menu_category
      @restaurant_menu_category = @restaurant.menu_categories.find_by!(id: params[:id]) if @restaurant
    end
end
