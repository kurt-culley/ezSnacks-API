class MenuItemsController < ApplicationController
  before_action :set_menu_category
  before_action :set_menu_category_item, only: [:show, :edit, :update, :destroy]

  def index
    json_response(@menu_category.menu_items)
  end

  def create
    @menu_category_item = @menu_category.menu_items.create!(menu_item_params)
    json_response(@menu_category_item, :created)
  end

  def show
    json_response(@menu_category_item)
  end

  def update
    @menu_category_item.update(menu_item_params)
    head :no_content
  end

  def destroy
    @menu_category_item.destroy
    head :no_content
  end

  private

    def menu_item_params
      params.permit(:name, :price, :image_url, :description)
    end

    def set_menu_category
      @menu_category = MenuCategory.find(params[:menu_category_id])
    end

    def set_menu_category_item
      @menu_category_item = @menu_category.menu_items.find_by!(id: params[:id]) if @menu_category
    end

end
