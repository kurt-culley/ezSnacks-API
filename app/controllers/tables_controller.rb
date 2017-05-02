class TablesController < ApplicationController
  before_action :set_restaurant
  before_action :set_restaurant_table, only: [:show, :update, :destroy]

  def index
    json_response(@restaurant.tables)
  end

  def create
    @restaurant_table = @restaurant.tables.create!(table_params)
    json_response(@restaurant_table, :created)
  end

  def show
    json_response(@restaurant_table)
  end

  def update
    @restaurant_table.update(table_params)
    head :no_content
  end

  def destroy
    @restaurant_table.destroy
    head :no_content
  end

  private

  def table_params
    params.permit(:status)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_restaurant_table
    @restaurant_table = @restaurant.tables.find_by!(id: params[:id]) if @restaurant
  end

end
