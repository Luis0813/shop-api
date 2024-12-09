require "rails_helper"
RSpec.describe "healt found", type: :request do
  let!(:create_params) { { "product" => { "name" => "name", "description" => "description", "price"=> 1.5, "discount_price"=> 22 } } }

  describe "index" do
    context "return product" do
      let!(:products) { create_list(:product, 10) }
      it "should return 10 product" do
        get "/product"
          payload = JSON.parse(response.body)
          expect(payload.size).to eq(10)
      end
    end
  end

  #   show

  describe "show" do
    context "return une product" do
    let!(:product1) { create(:product, name: "titulo") }
    before { get "/product/#{product1.id}" }
      it "description" do
        payload = JSON.parse(response.body)
        expect(payload["name"]).to eq("titulo")
      end
    end
  end

  #             CREATED
  describe "POST /create" do
    before { post "/product", params: create_params  }
    it "should create a post" do
      payload = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(payload).to include("id", "name", "description", "price")
      puts payload
    end
  end
  describe "PUT /update" do
  end
end
