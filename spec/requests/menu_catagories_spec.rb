require 'rails_helper'

RSpec.describe 'Menu Categories API', type: :request do
  # Initialize test data
  let!(:restaurants) { create_list(:restaurant, 2) }
  let!(:menu_categories) { create_list(:menu_category, 10, restaurant_id: restaurants.first.id) }
  let(:restaurant_id) { restaurants.first.id }
  let(:menu_category_id) { menu_categories.first.id }

  # GET /restaurants/:id/menu_categories
  describe 'GET /restaurants/:restaurant_id/menu_categories' do
    before { get "/restaurants/#{restaurant_id}/menu_categories" }

    context 'when menu categories exist' do
      it 'returns restaurant menu categories' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when menu categories do not exist' do
      let(:restaurant_id) { restaurants.second.id }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

    end
  end

  # GET /menu_categories/:id
  describe 'GET /menu_categories/:id' do
    before { get "/menu_categories/#{menu_category_id}" }

    context 'when menu_category exists' do
      it 'returns menu_category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(menu_category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when menu_category does not exist' do
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

    context 'when request is valid' do
      before { post "/restaurants/#{restaurant_id}/menu_categories", params: valid_attributes }

      it 'creates menu_category' do
        expect(json['name']).to eq('Pizza')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
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

  # PUT /menu_categories/:id
  describe 'PUT /menu_categories/:id' do
    let(:valid_attributes) { { name: 'Fish', image_url: 'http://google.com/imageurl' } }

    context 'when menu_category exists' do
      before { put "/menu_categories/#{menu_category_id}", params: valid_attributes }

      it 'updates menu_category' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /menu_categories/:id
  describe 'DELETE /menu_categories/:id' do
    before { delete "/menu_categories/#{menu_category_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end