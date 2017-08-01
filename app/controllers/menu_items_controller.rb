class MenuItemsController < ApplicationController

  before_action :set_menu_category, only: [:index, :create]
  before_action :set_menu_item, only: [:show, :update, :destroy]

  def index
    if @menu_category.menu_items.length > 0
      json_response(@menu_category.menu_items)
    else
      head :no_content
    end
  end

  def create
    @menu_category_item = @menu_category.menu_items.create!(menu_item_params)
    json_response(@menu_category_item, :created)
  end

  def show
    json_response(@menu_item)
  end

  def update
    @menu_item.update(menu_item_params)
    head :no_content
  end

  def destroy
    @menu_item.destroy
    head :no_content
  end

  private

    def menu_item_params
      params.permit(:name, :price, :image_url, :description)
    end

    def set_menu_category
      @menu_category = MenuCategory.find(params[:menu_category_id])
    end

    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

end
