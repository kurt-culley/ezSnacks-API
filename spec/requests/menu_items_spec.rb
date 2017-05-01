require 'rails_helper'

RSpec.describe 'Menu Items API', type: :request do
  # Initialize the test data
  let!(:menu_category) { create(:menu_category) }
  let!(:menu_items) { create_list(:menu_item, 20, menu_category_id: menu_category.id) }
  let(:menu_category_id) { menu_category.id }
  let(:id) { menu_items.first.id }

  # GET /menu_categories/:menu_category_id/menu_items
  describe 'GET /menu_categories/:menu_category_id/menu_items' do
    before { get "/menu_categories/#{menu_category_id}/menu_items" }

    context 'when menu_category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all menu_category menu_items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when menu_category does not exist' do
      let(:menu_category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MenuCategory/)
      end
    end
  end

  # GET /menu_categories/:menu_category_id/menu_items/:id
  describe 'GET /menu_categories/:menu_category_id/menu_items/:id' do
    before { get "/menu_categories/#{menu_category_id}/menu_items/#{id}" }

    context 'when menu_category menu_item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the menu_item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when menu_category menu_item does not exist' do
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

    context 'when request attributes are valid' do
      before { post "/menu_categories/#{menu_category_id}/menu_items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/menu_categories/#{menu_category_id}/menu_items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank, Description can't be blank, Image url can't be blank, Price can't be blank/)
        # Come back to this
      end
    end
  end

  # PUT /menu_categories/:menu_category_id/menu_items/:id
  describe 'PUT /menu_categories/:menu_category_id/menu_items/:id' do
    let(:valid_attributes) { { name: 'Pizza Special', price: '10', image_url: 'http://test.com/', description: 'Pizza.'} }

    before { put "/menu_categories/#{menu_category_id}/menu_items/#{id}", params: valid_attributes }

    context 'when menu_item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the menu_item' do
        updated_item = MenuItem.find(id)
        expect(updated_item.name).to match(/Pizza Special/)
      end
    end

    context 'when the menu_item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MenuItem/)
      end
    end
  end

  # DELETE /menu_categories/:menu_category_id/menu_items/:id
  describe 'DELETE /menu_categories/:menu_category_id/menu_items/:id' do
    before { delete "/menu_categories/#{menu_category_id}/menu_items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end