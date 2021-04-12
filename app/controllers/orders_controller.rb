# frozen_string_literal: true

# Orders Controller class
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]
  before_action :fetch_or_create_buyer, only: :create

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    render json: @orders, status: :found
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    render json: @order, status: :found if @order
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.save
      fetch_or_create_shipping
      fetch_or_create_items
      fetch_or_create_payments
      @order.submit_payload

      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.update(update_order_params)
      render json: @order, status: :ok, location: @order
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
    p buyer_hashes = parse_buyer_hashes(params.require(:buyer))
    buyer_params = params.require(:buyer).permit(
      :nickname, :email, :first_name, :last_name
    ).merge({
              external_id: params[:buyer][:id],
              phone: buyer_hashes[:phone],
              billing_info: buyer_hashes[:billing_info]
            })

    @buyer = Buyer.find_or_create_by(buyer_params)

    fetch_or_create_address(params.require(:shipping)) if @buyer
  end

  def fetch_or_create_address(shipping_params)
    address_hashes = parse_address_hashes(shipping_params.require(:receiver_address))
    address_params = shipping_params.require(:receiver_address).permit(
      :street_name, :street_number, :comment, :zip_code, :latitude,
      :longitude, :receiver_phone
    ).merge({
              buyer: @buyer, external_id: shipping_params[:receiver_address][:id], city: address_hashes[:city],
              state: address_hashes[:state], country: address_hashes[:country], neighborhood: address_hashes[:neighborhood]
            })

    @address = Address.find_or_create_by(address_params)
  end

  def fetch_or_create_shipping
    shipping_params = params.require(:shipping).permit(
      :shipment_type, :date_created, :receiver_address
    ).merge({ external_id: params[:shipping][:id], order: @order })

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
        :installments, :payment_type, :status, :transaction_amount, :taxes_amount, :shipping_cost,
        :total_paid_amount, :installment_amount, :date_approved, :date_created
      ).merge({
                external_id: payment_params[:id],
                order: @order,
                order_external_id: payment_params[:order_id],
                payer_external_id: payment_params[:payer_id]
              })

      Payment.create(create_params)
    end
  end

  def order_params
    params.permit(
      :store_id, :date_created, :date_cloased, :last_updated, :total_amount, :total_shipping,
      :total_amount_with_shipping, :paid_amount, :expiration_date, :status
    ).merge({ external_id: params[:id], buyer: @buyer })
  end

  def update_order_params
    params.permit(
      :store_id, :date_created, :date_cloased, :last_updated, :total_amount, :total_shipping,
      :total_amount_with_shipping, :paid_amount, :expiration_date, :status
    )
  end

  def parse_buyer_hashes(buyer_params)
    phone = { area_code: buyer_params[:phone][:area_code], number: buyer_params[:phone][:number] }
    billing_info = {
      doc_type: buyer_params[:billing_info][:doc_type], doc_number: buyer_params[:billing_info][:doc_number]
    }

    { phone: phone, billing_info: billing_info }
  end

  def parse_address_hashes(address_params)
    city = { name: address_params[:city][:name] }
    state = { name: address_params[:state][:name] }
    country = { id: address_params[:country][:id], name: address_params[:country][:name] }
    neighborhood = { id: address_params[:neighborhood][:id], name: address_params[:neighborhood][:name] }

    { city: city, state: state, country: country, neighborhood: neighborhood }
  end
end
