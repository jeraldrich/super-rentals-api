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

# TODO: Switch this to json-rb to follow json api spec.
class RentalsSerializer < ApplicationSerializer
  attributes :title, :city, :location, :category, :image, :street_address, :bedrooms, :description, :created_at, :updated_at
end
