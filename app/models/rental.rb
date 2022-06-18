class Rental < ApplicationRecord

  validates_presence_of :title
  validates_presence_of :city
  validates_presence_of :street_address
end
