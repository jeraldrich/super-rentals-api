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

class Rental < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  validates_presence_of :title
  validates_presence_of :city
  validates_presence_of :street_address
end
