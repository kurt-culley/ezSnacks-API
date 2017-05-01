require 'rails_helper'

RSpec.describe 'Menu Categories API', type: :request do
  # Initialize test data
  let!(:menu_categories) { create_list(:menu_category, 10) }
  let(:menu_category_id) { menu_categories.first.id }

  # GET /menu_categories
  describe 'GET /menu_categories' do

    before { get '/menu_categories' }

    it 'returns menu_categories' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /menu_categories/:id
  describe 'GET /menu_categories/:id' do
    before { get "/menu_categories/#{menu_category_id}" }

    context 'when the record exists' do
      it 'returns the menu_category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(menu_category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:menu_category_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MenuCategory/)
      end
    end
  end

  # POST /menu_categories
  describe 'POST /menu_categories' do
    # valid payload
    let(:valid_attributes) { { name: 'Pizza' } }

    context 'when the request is valid' do
      before { post '/menu_categories', params: valid_attributes }

      it 'creates a menu_category' do
        expect(json['name']).to eq('Pizza')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/menu_categories', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # PUT /todos/:id
  describe 'PUT /menu_categories/:id' do
    let(:valid_attributes) { { name: 'Fish' } }

    context 'when the record exists' do
      before { put "/menu_categories/#{menu_category_id}", params: valid_attributes }

      it 'updates the record' do
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