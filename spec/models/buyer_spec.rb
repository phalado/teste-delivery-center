# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Buyer, type: :model do
  describe 'Test factory' do
    let!(:order) { build(:order) }

    it 'is valid' do
      expect(order).to be_valid
    end
  end

  describe 'test presence of columns' do
    test_cases = %i[external_id nickname email phone first_name last_name billing_info]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should have_many(:orders) }
  end
end
