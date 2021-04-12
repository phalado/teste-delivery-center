# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :buyer

  has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_one :shipping, dependent: :destroy

  def submit_payload
    # p ''
    # p ''
    # p self
    # p self.buyer
    # p self.order_items
    # p self.payments
    # p self.shipping
    # p self.shipping.receiver_address
    # p ''
    # p ''
    p payload
  end

  private

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
      complement: '',
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

  def customer_payload
    {
      externalCode: buyer.external_id.to_s,
      name: buyer.nickname,
      email: buyer.email,
      contact: buyer.phone['area_code'].to_s + buyer.phone['number']
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
      %w[Amapá AP],
      %w[Amazonas AM],
      %w[Bahia BA],
      %w[Ceará CE],
      ['Distrito Federal', 'DF'],
      ['Espírito Santo', 'ES'],
      %w[Goiás GO],
      %w[Maranhão MA],
      ['Mato Grosso', 'MT'],
      ['Mato Grosso do Sul', 'MS'],
      ['Minas Gerais', 'MG'],
      %w[Pará PA],
      %w[Paraíba PB],
      %w[Paraná PR],
      %w[Pernambuco PE],
      %w[Piauí PI],
      ['Rio de Janeiro', 'RJ'],
      ['Rio Grande do Norte', 'RN'],
      ['Rio Grande do Sul', 'RS'],
      %w[Rondônia RO],
      %w[Roraima RR],
      ['Santa Catarina', 'SC'],
      ['São Paulo', 'SP'],
      %w[Sergipe SE],
      %w[Tocantins TO]
    ]

    states.select { |st| st.first == state }.first ? states.select { |st| st.first == state }.first.second : state
  end
end
