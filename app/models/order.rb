# frozen_string_literal: true

require 'json'

# Order model
class Order < ApplicationRecord
  belongs_to :buyer

  has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_one :shipping, dependent: :destroy

  def submit_payload
    payload = self.payload.to_json
    url = 'https://delivery-center-recruitment-ap.herokuapp.com'
    headers = { 'X-Sent': DateTime.now.strftime('%Hh%M-%d/%m/%y') }
    site = RestClient::Resource.new url

    site['/'].post payload, headers
  end

  def payload
    {
      externalCode: external_id,
      storeId: store_id,
      subTotal: format('%.2f', total_amount),
      deliveryFee: format('%.2f', total_shipping),
      total_shipping: total_shipping,
      total: format('%.2f', total_amount_with_shipping),
      country: shipping.receiver_address.country['id'],
      state: brazilian_state_by_id(shipping.receiver_address.state['name']),
      city: shipping.receiver_address.city['name'],
      district: shipping.receiver_address.neighborhood['name'],
      street: shipping.receiver_address.street_name,
      complement: 'house',
      latitude: shipping.receiver_address.latitude,
      longitude: shipping.receiver_address.longitude,
      dtOrderCreate: date_created.strftime('%FT%T.%LZ'),
      postalCode: shipping.receiver_address.zip_code,
      number: '0',
      customer: customer_payload,
      items: items_payload,
      payments: payments_payload
    }
  end

  private

  def customer_payload
    {
      externalCode: buyer.external_id.to_s,
      name: buyer.nickname,
      email: buyer.email,
      contact: buyer.phone['area_code'].to_s + buyer.phone['number'].to_s
    }
  end

  def items_payload
    payload = []

    order_items.each do |item|
      payload << {
        externalCode: item.item['id'],
        name: item.item['title'],
        price: item.unit_price,
        quantity: item.quantity,
        total: item.full_unit_price,
        subItems: []
      }
    end

    payload
  end

  def payments_payload
    payload = []

    payments.each do |payment|
      payload << {
        type: payment.payment_type.upcase,
        value: payment.total_paid_amount
      }
    end

    payload
  end

  def brazilian_state_by_id(state)
    states = [
      %w[Acre AC],
      %w[Alagoas AL],
      %w[Amap?? AP],
      %w[Amazonas AM],
      %w[Bahia BA],
      %w[Cear?? CE],
      ['Distrito Federal', 'DF'],
      ['Esp??rito Santo', 'ES'],
      %w[Goi??s GO],
      %w[Maranh??o MA],
      ['Mato Grosso', 'MT'],
      ['Mato Grosso do Sul', 'MS'],
      ['Minas Gerais', 'MG'],
      %w[Par?? PA],
      %w[Para??ba PB],
      %w[Paran?? PR],
      %w[Pernambuco PE],
      %w[Piau?? PI],
      ['Rio de Janeiro', 'RJ'],
      ['Rio Grande do Norte', 'RN'],
      ['Rio Grande do Sul', 'RS'],
      %w[Rond??nia RO],
      %w[Roraima RR],
      ['Santa Catarina', 'SC'],
      ['S??o Paulo', 'SP'],
      %w[Sergipe SE],
      %w[Tocantins TO]
    ]

    states.select { |st| st.first == state }.first ? states.select { |st| st.first == state }.first.second : state
  end
end
