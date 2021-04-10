# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'Test factory' do
    let!(:payment) { build(:payment, order: create(:order)) }

    it 'is valid' do
      expect(payment).to be_valid
    end
  end

  describe 'test presence of columns' do
    test_cases = %i[
      order_id external_id order_external_id payer_external_id installments payment_type status transaction_amount
      taxes_amount shipping_cost total_paid_amount installment_amount date_approved date_created
    ]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should belong_to(:order) }
  end

  describe 'test validations' do
    test_cases = %i[external_id order_external_id payer_external_id]

    test_cases.each do |present_column|
      it { should validate_presence_of present_column }
    end
  end
end
