require 'rails_helper'

describe Rental do
  let!(:rental) { create(:rental) }

  # it { should belong_to(:owner) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:street_address) }
end