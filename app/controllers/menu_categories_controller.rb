class MenuCategoriesController < ApplicationController

  before_action :set_menu_category, only: [:show, :edit, :update, :destroy]

  def index
    @menu_categories = MenuCategory.all
    json_response(@menu_categories)
  end

  def create
    @menu_category = MenuCategory.create!(menu_category_params)
    json_response(@menu_category, :created)
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
      params.permit(:name)
    end

    def set_menu_category
      @menu_category = MenuCategory.find(params[:id])
    end
end
