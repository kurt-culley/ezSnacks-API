require 'rails_helper'

RSpec.describe 'Restaurants API', type: :request do
  # Initialize test data
  let!(:restaurants) { create_list(:restaurant, 10) }
  let!(:table) { create(:table, restaurant_id: restaurants.first.id)}
  let!(:orders) { create_list(:order, 10, table_id: table.id) }

  let(:table_id) { table.id }
  let(:restaurant_id) { restaurants.first.id }
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

    context 'when orders do not exist' do
      let(:restaurant_id) { restaurants.second.id }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # GET /restaurants
  describe 'GET /restaurants' do
    before { get '/restaurants' }

    it 'returns restaurants' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /restaurants/:id
  describe 'GET /restaurants/:id' do
    before { get "/restaurants/#{restaurant_id}" }

    context 'when restaurant exists' do
      it 'returns restaurant' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(restaurant_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when restaurant does not exist' do
      let(:restaurant_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Restaurant/)
      end
    end
  end

  # POST /restaurants
  describe 'POST /restaurants' do
    # valid payload
    let(:valid_attributes) { { name: 'Cake shop' } }

    context 'when request is valid' do
      before { post '/restaurants', params: valid_attributes }

      it 'creates a table' do
        expect(json['name']).to eq('Cake shop')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/restaurants', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # PUT /restaurants/:id
  describe 'PUT /restaurants/:id' do
    let(:valid_attributes) { { name: 'Sandwich shop' } }

    context 'when restaurant exists' do
      before { put "/restaurants/#{restaurant_id}", params: valid_attributes }

      it 'updates restaurant' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /restaurants/:id
  describe 'DELETE /restaurants/:id' do
    before { delete "/restaurants/#{restaurant_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end