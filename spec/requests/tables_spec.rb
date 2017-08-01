require 'rails_helper'

RSpec.describe 'Tables API', type: :request do
  # Initialize test data
  let!(:restaurants) { create_list(:restaurant, 2) }
  let!(:tables) { create_list(:table, 20, restaurant_id: restaurants.first.id) }
  let(:restaurant_id) { restaurants.first.id }
  let(:id) { tables.first.id }

  # GET /restaurants/:restaurant_id/tables
  describe 'GET /restaurants/:restaurant_id/tables' do

    before { get "/restaurants/#{restaurant_id}/tables" }

    context 'when tables exist' do
      it 'returns tables' do
        expect(json).not_to be_empty
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when tables do not exist' do
      let(:restaurant_id) { restaurants.second.id }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # GET /tables/:id
  describe 'GET /tables/:id' do
    before { get "/tables/#{id}" }

    context 'when table exists' do
      it 'returns table' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when table does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Table/)
      end
    end
  end

  # POST /restaurants/:restaurant_id/tables
  describe 'POST /restaurants/:restaurant_id/tables' do
    # valid payload
    let(:valid_attributes) { { status: 1 } }

    context 'when request is valid' do
      before { post "/restaurants/#{restaurant_id}/tables", params: valid_attributes }

      it 'creates a restaurant table' do
        expect(json['status']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post "/restaurants/#{restaurant_id}/tables", params: { status: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Status can't be blank/)
      end
    end
  end

  # PUT /tables/:id
  describe 'PUT /restaurants/:restaurant_id/tables/:id' do
    let(:valid_attributes) { { status: '0' } }

    context 'when table exists' do
      before { put "/tables/#{id}", params: valid_attributes }

      it 'updates table' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /tables/:id
  describe 'DELETE /tables/:id' do
    before { delete "/tables/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end