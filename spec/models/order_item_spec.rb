# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Test factory' do
    let!(:order_item) { build(:order_item, order: create(:order)) }

    it 'is valid' do
      expect(order_item).to be_valid
    end
  end

  describe 'test presence of columns' do
    test_cases = %i[order_id item quantity unit_price full_unit_price]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should belong_to(:order) }
  end

  describe 'test validations' do
    test_cases = %i[item quantity unit_price]

    test_cases.each do |present_column|
      it { should validate_presence_of present_column }
    end
  end
end
