class MenuCategoriesController < ApplicationController

  before_action :set_restaurant, only: [:index, :create]
  before_action :set_menu_category, only: [:show, :update, :destroy]

  def index
    if @restaurant.menu_categories.length > 0
      json_response(@restaurant.menu_categories)
    else
      head :no_content
    end
  end

  def create
    @restaurant_menu_category = @restaurant.menu_categories.create!(menu_category_params)
    json_response(@restaurant_menu_category, :created)
  end

  def show
    json_response(@menu_category)
  end

  def update
    @menu_category.update(menu_category_params)
    head :no_content
  end

  def destroy
    @menu_category.destroy
    head :no_content
  end

  private

    def menu_category_params
      params.permit(:name, :image_url)
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def set_menu_category
      @menu_category = MenuCategory.find(params[:id])
    end

end
