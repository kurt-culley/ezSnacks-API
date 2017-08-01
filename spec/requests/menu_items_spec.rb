require 'rails_helper'

RSpec.describe 'Menu Items API', type: :request do
  # Initialize the test data
  let!(:restaurant) { create(:restaurant) }
  let!(:menu_categories) { create_list(:menu_category, 2, restaurant_id: restaurant.id) }
  let!(:menu_items) { create_list(:menu_item, 20, menu_category_id: menu_categories.first.id) }
  let(:menu_category_id) { menu_categories.first.id }
  let(:id) { menu_items.first.id }

  # GET /menu_categories/:menu_category_id/menu_items
  describe 'GET /menu_categories/:menu_category_id/menu_items' do
    before { get "/menu_categories/#{menu_category_id}/menu_items" }

    context 'when menu items exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns menu items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when menu items do not exist' do
      let(:menu_category_id) { menu_categories.second.id }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # GET /menu_items/:id
  describe 'GET /menu_items/:id' do
    before { get "/menu_items/#{id}" }

    context 'when menu item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns menu item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when menu item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MenuItem/)
      end
    end
  end

  # POST /menu_categories/:menu_category_id/menu_items
  describe 'POST /menu_categories/:menu_categories_id/menu_items' do
    let(:valid_attributes) { { name: 'Pizza', price: '5', image_url: 'http://test.com/', description: 'Tasty snack.'} }

    context 'when request is valid' do
      before { post "/menu_categories/#{menu_category_id}/menu_items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post "/menu_categories/#{menu_category_id}/menu_items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank, Description can't be blank, Image url can't be blank, Price can't be blank/)
      end
    end
  end

  # PUT /menu_items/:id
  describe 'PUT /menu_items/:id' do
    let(:valid_attributes) { { name: 'Pizza Special', price: '10', image_url: 'http://test.com/', description: 'Pizza.'} }

    context 'when menu_item exists' do
      before { put "/menu_items/#{id}", params: valid_attributes }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates menu_item' do
        expect(response.body).to be_empty
      end
    end
  end

  # DELETE /menu_items/:id
  describe 'DELETE /menu_items/:id' do
    before { delete "/menu_items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end