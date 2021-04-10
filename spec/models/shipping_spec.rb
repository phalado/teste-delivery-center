# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe 'Test factory' do
    let!(:shipping) { build(:shipping) }

    it 'is valid' do
      expect(shipping).to be_valid
    end
  end

  describe 'test presence of columns' do
    test_cases = %i[external_id shipment_type date_created receiver_address]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should belong_to(:order) }
    it { should have_one(:receiver_address).class_name('Address') }
  end
end
