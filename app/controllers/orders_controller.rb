# frozen_string_literal: true

# Orders Controller class
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]
  before_action :fetch_or_create_buyer, only: :create

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show; end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.save
      fetch_or_create_shipping
      fetch_or_create_items
      # fetch_or_create_payments

      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.update(order_params)
      render :show, status: :ok, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def fetch_or_create_buyer
    buyer_params = params.require(:buyer).permit(
      :nickname, :email, :phone, :first_name, :last_name, :billing_info
    ).merge({ external_id: params[:buyer][:id] })

    @buyer = Buyer.find_or_create_by(buyer_params)

    fetch_or_create_address if @buyer
  end

  def fetch_or_create_address
    adress_params = params.require(:shipping).require(:receiver_address).permit(
      :street_name, :street_number, :comment, :zip_code, :city, :state, :country, :neighborhood, :latitude,
      :longitude, :receiver_phone
    ).merge({ buyer: @buyer, external_id: params[:shipping][:receiver_address][:id] })

    @address = Address.find_or_create_by(adress_params)
  end

  def fetch_or_create_shipping
    shipping_params = params.require(:shipping).permit(
      :shipment_type, :date_created, :receiver_address
    ).merge({ external_id: params[:shipping][:id] })

    @shipping = Shipping.create(shipping_params)
    @address.update!(shipping: @shipping)
  end

  def fetch_or_create_items
    params[:order_items].each do |item_params|
      item = item_params.require(:item).permit(:id, :title)
      create_params = item_params.permit(
        :quantity, :unit_price, :full_unit_price
      ).merge({ order: @order, item: item })

      OrderItem.create(create_params)
    end
  end

  def fetch_or_create_payments
    params[:payments].each do |payment_params|
      create_params = payment_params.permit(
        :order_external_id, :payer_external_id, :installments, :payment_type, :status, :transaction_amount,
        :taxes_amount, :shipping_cost, :total_paid_amount, :installment_amount, :date_approved, :date_created
      ).merge({ external_id: payment_params[:id], order: @order })

      Payment.create(create_params)
    end
  end

  def order_params
    params.permit(
      :store_id, :date_created, :date_cloased, :last_updated, :total_amount, :total_shipping,
      :total_amount_with_shipping, :paid_amount, :expiration_date, :status
    ).merge({ external_id: params[:id], buyer: @buyer })
  end
end
