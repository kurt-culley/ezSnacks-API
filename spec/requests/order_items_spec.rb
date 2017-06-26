require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  # Initialize test data
  let!(:restaurant) { create(:restaurant) }
  let!(:menu_category) { create(:menu_category, restaurant_id: restaurant.id) }
  let!(:menu_items) { create_list(:menu_item, 2, menu_category_id: menu_category.id) }
  let!(:table) { create(:table, restaurant_id: restaurant.id)}
  let!(:order) { create(:order, restaurant_id: restaurant.id, table_id: table.id) }
  let!(:order_item) { create(:order_item, menu_item_id: menu_items.first.id, order_id: order.id)}

  let(:restaurant_id) { restaurant.id }
  let(:menu_item_id) {menu_items.first.id}
  let(:order_id) { order.id }
  let(:order_item_id) {order_item.id}

  # GET /restaurants/:restaurant_id/orders/:order_id/items
  describe 'GET /restaurants/:restaurant_id/orders/:order_id/items' do
    before { get "/restaurants/#{restaurant_id}/orders/#{order_id}/items" }

    context 'when order / items exist' do
      it 'returns order items' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when order / items do not exist' do
      let(:order_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # GET /restaurants/:restaurant_id/orders/:order_id/items/:id
  describe 'GET /restaurants/:restaurant_id/orders/:order_id/items/:id' do
    before { get "/restaurants/#{restaurant_id}/orders/#{order_id}/items/#{order_item_id}" }

    context 'when the order item exists' do
      it 'returns the order item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(order_item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the order item does not exist' do
      let(:order_item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderItem/)
      end
    end
  end

  # POST /restaurants/:restaurant_id/orders/:order_id/items
  describe 'POST /restaurants/:restaurant_id/orders/:order_id/items' do
    # valid payload
    let(:valid_attributes) { { menu_item_id: menu_items.second.id } }

    context 'when the request is valid' do
      before { post "/restaurants/#{restaurant_id}/orders/#{order_id}/items", params: valid_attributes }

      it 'creates an order item' do
        expect(json['quantity']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/restaurants/#{restaurant_id}/orders/#{order_id}/items", params: {  } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Couldn't find MenuItem/)
      end
    end
  end

  # POST /restaurants/:restaurant_id/orders/:order_id/items/:item_id/add
  describe 'POST /restaurants/:restaurant_id/orders/:order_id/items/:item_id/add' do

    context 'when the order item exists' do
      before { post "/restaurants/#{restaurant_id}/orders/#{order_id}/items/#{order_item_id}/add" }

      it 'increases order item quantity' do
        expect(json['quantity']).to eq(2)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # POST /restaurants/:restaurant_id/orders/:order_id/items/:item_id/reduce
  describe 'POST /restaurants/:restaurant_id/orders/:order_id/items/:item_id/reduce' do

    context 'when the order item exists' do
      before { post "/restaurants/#{restaurant_id}/orders/#{order_id}/items/#{order_item_id}/reduce" }

      it 'reduces order item quantity' do
        expect(json['quantity']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # DELETE /restaurants/:restaurant_id/orders/:order_id/items/:item_id
  describe 'DELETE /restaurants/:restaurant_id/order/:order_id/items/:item_id' do
    before { delete "/restaurants/#{restaurant_id}/orders/#{order_id}/items/#{order_item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end