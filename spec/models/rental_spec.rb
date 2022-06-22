# == Schema Information
#
# Table name: rentals
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  title          :string
#  city           :string
#  location       :string
#  category       :string
#  image          :string
#  street_address :string
#  bedrooms       :integer
#  description    :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

describe Rental do
  let!(:rental) { create(:rental) }

  # it { should belong_to(:owner) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:street_address) }
end
