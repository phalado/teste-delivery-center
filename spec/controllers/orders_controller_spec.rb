require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "#index" do
    let!(:orders) { create_list(:order, 2) }

    it 'request is answered' do
      get :index, as: :json
      expect(assigns(:orders)).to be_present
      expect(assigns(:orders).count).to be(2)
      expect(response).to have_http_status(:found)
    end
  end

  describe "#show" do
    let!(:order) { create(:order) }

    it 'request is answered' do
      get :show, as: :json, params: { id: order.id }
      expect(assigns(:order)).to be_present
      expect(response).to have_http_status(:found)
    end
  end

  describe "#delete" do
    let!(:order) { create(:order) }

    it 'delete order' do
      expect do
        delete :destroy, as: :json, params: { id: order.id }
      end.to change { Order.count }.by(-1)
    end
  end

  describe "#update" do
    let!(:order) { create(:order) }
    
    it 'update orde\'s status' do
      expect do
        patch :update, as: :json, params: { id: order.id, status: "not paid" }
        order.reload
      end.to change { order.status }.to('not paid')
    end
  end

  describe "#create" do
    it 'create an order' do
      expect do
        post :create, as: :json, params: order_payload_params
      end.to change { Order.count }.by(1)
    end

    it 'create a buyer' do
      expect do
        post :create, as: :json, params: order_payload_params
      end.to change { Buyer.count }.by(1)
    end

    it 'create an order item' do
      expect do
        post :create, as: :json, params: order_payload_params
      end.to change { OrderItem.count }.by(1)
    end

    it 'create an address' do
      expect do
        post :create, as: :json, params: order_payload_params
      end.to change { Address.count }.by(1)
    end

    it 'create a shipping' do
      expect do
        post :create, as: :json, params: order_payload_params
      end.to change { Shipping.count }.by(1)
    end

    it 'create a payment' do
      expect do
        post :create, as: :json, params: order_payload_params
      end.to change { Payment.count }.by(1)
    end
  end
end
