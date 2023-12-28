require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET api/v1/products" do
    context "データが存在するとき" do
      let!(:products) { create_list(:product, 3) }
      it "商品の一覧が取得できること" do
        get "/api/v1/products"

        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json.length).to eq(3)

        expect(json.first.keys).to contain_exactly('id', 'name','price', 'description', 'image_url')
      end
    end
  end

  describe "GET api/v1/products/:id" do
    context "データが存在するとき" do
      let!(:product) { create(:product) }
      it "商品の詳細が取得できること" do
        get "/api/v1/products/#{product.id}"

        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json.keys).to contain_exactly('id', 'name','price', 'description', 'image_url')
      end
    end
  end
end
