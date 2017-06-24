require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  # Initialize test data
  let!(:restaurant) { create(:restaurant) }
  let!(:table) { create(:table, restaurant_id: restaurant.id)}
  let!(:orders) { create_list(:order, 10, restaurant_id: restaurant.id, table_id: table.id) }
  let(:table_id) { table.id }
  let(:restaurant_id) { restaurant.id }
  let(:order_id) { orders.first.id }

  # GET /restaurants/:id/orders
  describe 'GET /restaurants/:restaurant_id/orders' do
    before { get "/restaurants/#{restaurant_id}/orders" }

    context 'when restaurant exists' do
      it 'returns restaurant orders' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when restaurant does not exist' do
      let(:restaurant_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Restaurant/)
      end
    end
  end

  # GET /restaurants/:id/orders/:id
  describe 'GET /restaurants/orders/:id' do
    before { get "/restaurants/#{restaurant_id}/orders/#{order_id}" }

    context 'when the restaurant order exists' do
      it 'returns the order' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(order_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the restaurant order does not exist' do
      let(:order_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # POST /restaurants/:restaurant_id/orders
  describe 'POST /restaurants/:restaurant_id/orders' do
    # valid payload
    let(:valid_attributes) { { table_id: :table_id } }

    context 'when the request is valid' do
      before { post "/restaurants/#{restaurant_id}/orders", params: valid_attributes }

      it 'creates a restaurant order' do
        expect(json['sub_total']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/restaurants/#{restaurant_id}/orders", params: { table_id: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Table can't be blank/)

      end
    end
  end

  # PUT /restaurants/:restaurant_id/orders/:id
  describe 'PUT /restaurants/:restaurant_id/orders/:id' do
    let(:valid_attributes) { { table_id: :table_id } }

    context 'when the restaurant order exists' do
      before { put "/restaurants/#{restaurant_id}/orders/#{order_id}", params: valid_attributes }

      it 'updates the restaurant order' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /restaurants/:restaurant_id/menu_categories/:id
  describe 'DELETE /restaurants/:restaurant_id/menu_categories/:id' do
    before { delete "/restaurants/#{restaurant_id}/orders/#{order_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end