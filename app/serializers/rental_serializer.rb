# == Schema Information
#
# Table name: rentals
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  title          :string
#  city           :string
#  lat            :float
#  lng            :float
#  category       :string
#  image          :string
#  street_address :string
#  bedrooms       :integer
#  description    :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class RentalSerializer < JSONAPI::Serializable::Resource
  type 'rentals'

  attributes :title, :city, :category, :image, :street_address, :bedrooms, :description, :created_at, :updated_at

  attribute :owner do
    "#{@object.owner.first_name} #{@object.owner.last_name}"
  end

  attribute :location do
    {'lat': @object.lat, 'lng': @object.lng}
  end
end
