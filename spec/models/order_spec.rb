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
      external_id store_id date_created date_cloased last_updated total_amount total_shipping total_amount_with_shipping paid_amount expiration_date status
    ]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should have_many(:order_items).dependent(:destroy) }
  end
end
