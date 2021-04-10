# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Test factory' do
    let!(:address) { build(:address, buyer: create(:buyer)) }

    it 'is valid' do
      expect(address).to be_valid
    end
  end

  describe 'test presence of columns' do
    test_cases = %i[
      external_id street_name street_number comment zip_code city state
      country neighborhood latitude longitude receiver_phone
    ]

    test_cases.each do |column|
      it { should have_db_column column }
    end
  end

  describe 'test associations' do
    it { should belong_to(:buyer) }
  end
end
