require 'rails_helper'

RSpec.describe 'Order Item API', type: :request do
  # Initialize test data
  let!(:restaurant) { create(:restaurant) }
  let!(:menu_category) { create(:menu_category, restaurant_id: restaurant.id) }
  let!(:menu_items) { create_list(:menu_item, 2, menu_category_id: menu_category.id) }
  let!(:table) { create(:table, restaurant_id: restaurant.id)}
  let!(:orders) { create_list(:order, 2, table_id: table.id) }
  let!(:order_item) { create(:order_item, menu_item_id: menu_items.first.id, order_id: orders.first.id)}

  let(:menu_item_id) {menu_items.first.id}
  let(:order_id) { orders.first.id }
  let(:order_item_id) {order_item.id}

  # GET /orders/:order_id/items
  describe 'GET /orders/:order_id/items' do
    before { get "/orders/#{order_id}/items" }

    context 'when items exist' do
      it 'returns items' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when items do not exist' do
      let(:order_id) { orders.second.id }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # GET /orders/:order_id/items/:id
  describe 'GET /orders/:order_id/items/:id' do
    before { get "/orders/#{order_id}/items/#{order_item_id}" }

    context 'when item exists' do
      it 'returns item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(order_item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when item does not exist' do
      let(:order_item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OrderItem/)
      end
    end
  end

  # POST /orders/:order_id/items
  describe 'POST /orders/:order_id/items' do
    # valid payload
    let(:valid_attributes) { { menu_item_id: menu_items.second.id } }

    context 'when request is valid' do
      before { post "/orders/#{order_id}/items", params: valid_attributes }

      it 'creates an order item' do
        expect(json['quantity']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post "/orders/#{order_id}/items", params: {  } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Couldn't find MenuItem/)
      end
    end
  end

  # POST /orders/:order_id/items/:item_id/add
  describe 'POST /orders/:order_id/items/:item_id/add' do

    context 'when order item exists' do
      before { post "/orders/#{order_id}/items/#{order_item_id}/add" }

      it 'increases order item quantity' do
        expect(json['quantity']).to eq(2)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # POST /orders/:order_id/items/:item_id/reduce
  describe 'POST /orders/:order_id/items/:item_id/reduce' do

    context 'when order item exists' do
      before { post "/orders/#{order_id}/items/#{order_item_id}/reduce" }

      it 'reduces order item quantity' do
        expect(json['quantity']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # DELETE /orders/:order_id/items/:item_id
  describe 'DELETE /order/:order_id/items/:item_id' do
    before { delete "/orders/#{order_id}/items/#{order_item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end