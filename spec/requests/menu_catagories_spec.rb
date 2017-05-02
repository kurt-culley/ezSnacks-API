require 'rails_helper'

RSpec.describe 'Menu Categories API', type: :request do
  # Initialize test data
  let!(:restaurant) { create(:restaurant) }
  let!(:menu_categories) { create_list(:menu_category, 10, restaurant_id: restaurant.id) }
  let(:restaurant_id) { restaurant.id }
  let(:menu_category_id) { menu_categories.first.id }

  # GET /restaurants/:id/menu_categories
  describe 'GET /restaurants/:restaurant_id/menu_categories' do
    before { get "/restaurants/#{restaurant_id}/menu_categories" }

    context 'when restaurant exists' do
      it 'returns restaurant menu_categories' do
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

  # GET /restaurants/:id/menu_categories/:id
  describe 'GET /restaurants/menu_categories/:id' do
    before { get "/restaurants/#{restaurant_id}/menu_categories/#{menu_category_id}" }

    context 'when the restaurant menu_category exists' do
      it 'returns the menu_category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(menu_category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the restaurant menu_category does not exist' do
      let(:menu_category_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MenuCategory/)
      end
    end
  end

  # POST /restaurants/:restaurant_id/menu_categories
  describe 'POST /restaurants/:restaurant_id/menu_categories' do
    # valid payload
    let(:valid_attributes) { { name: 'Pizza', image_url: 'http://google.com' } }

    context 'when the request is valid' do
      before { post "/restaurants/#{restaurant_id}/menu_categories", params: valid_attributes }

      it 'creates a menu_category' do
        expect(json['name']).to eq('Pizza')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/restaurants/#{restaurant_id}/menu_categories", params: { name: '', image_url: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Name can't be blank, Image url can't be blank/)
      end
    end
  end

  # PUT /restaurants/:restaurant_id/menu_categories/:id
  describe 'PUT /restaurants/:restaurant_id/menu_categories/:id' do
    let(:valid_attributes) { { name: 'Fish', image_url: 'http://google.com/imageurl' } }

    context 'when the restaurant menu_category exists' do
      before { put "/restaurants/#{restaurant_id}/menu_categories/#{menu_category_id}", params: valid_attributes }

      it 'updates the restaurant menu_category' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /restaurants/:restaurant_id/menu_categories/:id
  describe 'DELETE /restaurants/:restaurant_id/menu_categories/:id' do
    before { delete "/restaurants/#{restaurant_id}/menu_categories/#{menu_category_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end