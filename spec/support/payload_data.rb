module PayloadData
  def order_payload_array(order)
    [
      [:externalCode, order.external_id],
      [:storeId, order.store_id],
      [:subTotal, format('%.2f', order.total_amount)],
      [:deliveryFee, order.total_shipping.to_s],
      [:total_shipping, order.total_shipping],
      [:total, format('%.2f', order.total_amount_with_shipping)],
      [:country, order.shipping.receiver_address.country['id']],
      [:state, order.shipping.receiver_address.state['name']],
      [:city, order.shipping.receiver_address.city['name']],
      [:district, order.shipping.receiver_address.neighborhood['name']],
      [:street, order.shipping.receiver_address.street_name],
      [:complement, ''],
      [:latitude, order.shipping.receiver_address.latitude],
      [:longitude, order.shipping.receiver_address.longitude],
      [:dtOrderCreate, order.date_created.strftime('%FT%T.%LZ')],
      [:postalCode, order.shipping.receiver_address.zip_code],
      [:number, '0']
    ]
  end

  def customer_payload_array(buyer)
    [
      [:externalCode, buyer.external_id.to_s],
      [:name, buyer.nickname],
      [:email, buyer.email],
      [:contact, buyer.phone['area_code'].to_s + buyer.phone['number'].to_s]
    ]
  end

  def items_payload_array(item)
    [
      [:externalCode, item.item['id']],
      [:name, item.item['title']],
      [:price, item.unit_price],
      [:quantity, item.quantity],
      [:total, item.full_unit_price]
    ]
  end

  def payments_payload_array(payment)
    [
      [:type, payment.payment_type.upcase],
      [:value, payment.total_paid_amount],
    ]
  end
end