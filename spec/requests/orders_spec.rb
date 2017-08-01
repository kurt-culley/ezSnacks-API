require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  # Initialize test data
  let!(:restaurant) { create(:restaurant) }
  let!(:table) { create(:table, restaurant_id: restaurant.id)}
  let!(:orders) { create_list(:order, 10, table_id: table.id) }

  let(:table_id) { table.id }
  let(:restaurant_id) { restaurant.id }
  let(:order_id) { orders.first.id }

  # GET /orders/:id
  describe 'GET /orders/:id' do
    before { get "/orders/#{order_id}" }

    context 'when order exists' do
      it 'returns order' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(order_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when order does not exist' do
      let(:order_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Order/)
      end
    end
  end

  # POST /tables/:table_id/orders
  describe 'POST /tables/:table_id/orders' do

    context 'when request is valid' do
      before { post "/tables/#{table_id}/orders" }

      it 'creates order' do
        expect(json['sub_total']).to eq(0)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # PUT /orders/:id
  describe 'PUT /orders/:id' do
    let(:valid_attributes) { { status: 'pending_payment' } }

    context 'when order exists' do
      before { put "/orders/#{order_id}", params: valid_attributes }

      it 'updates order' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /orders/:id
  describe 'DELETE /orders/:id' do
    before { delete "/orders/#{order_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end