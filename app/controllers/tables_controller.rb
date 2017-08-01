class TablesController < ApplicationController
  before_action :set_restaurant, only: [:index, :create]
  before_action :set_table, only: [:show, :update, :destroy]

  def index
    if @restaurant.tables.length > 0
      json_response(@restaurant.tables)
    else
      head :no_content
    end
  end

  def create
    @restaurant_table = @restaurant.tables.create!(table_params)
    json_response(@restaurant_table, :created)
  end

  def show
    json_response(@table)
  end

  def update
    @table.update(table_params)
    head :no_content
  end

  def destroy
    @table.destroy
    head :no_content
  end

  private

  def table_params
    params.permit(:status)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_table
    @table = Table.find(params[:id])
  end

end
