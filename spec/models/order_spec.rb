# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Test factory' do
    let!(:order) { build(:order) }

    it 'is valid' do
      expect(order).to be_valid
    end
  end

  describe 'test presence of columns' do
    test_cases = %i[
      external_id store_id date_created date_cloased last_updated total_amount
      total_shipping total_amount_with_shipping paid_amount expiration_date status
    ]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should belong_to(:buyer) }
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:payments).dependent(:destroy) }
    it { should have_one(:shipping).dependent(:destroy) }
  end

  describe 'test methods' do
    let!(:buyer) { create(:buyer) }
    let!(:order) { create(:order, buyer: buyer) }
    let!(:shipping) { create(:shipping, order: order) }
    let!(:address) { create(:address, buyer: buyer, shipping: shipping) }
    let!(:order_item) { create(:order_item, order: order) }
    let!(:payment) { create(:payment, order: order) }

    let(:payload) { order.send(:payload) }

    it 'test if the payload is loading correctly' do
      order_payload_array(order).each do |test|
        expect(payload).to have_key(test.first)
        expect(payload[test.first]).to eq(test.second)
      end
    end

    it 'test if the customer payload is loading correctly' do
      customer_payload_array(buyer).each do |test|
        expect(payload[:customer]).to have_key(test.first)
        expect(payload[:customer][test.first]).to eq(test.second)
      end
    end

    it 'test if the item payload is loading correctly' do
      items_payload_array(order_item).each do |test|
        expect(payload[:items].first).to have_key(test.first)
        expect(payload[:items].first[test.first]).to eq(test.second)
      end
    end

    it 'test if the item payload is loading correctly' do
      payments_payload_array(payment).each do |test|
        expect(payload[:payments].first).to have_key(test.first)
        expect(payload[:payments].first[test.first]).to eq(test.second)
      end
    end
  end
end
