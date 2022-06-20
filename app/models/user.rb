# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  api_key                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :confirmable, :timeoutable, :trackable, :validatable
  
  after_create :create_api_key
  
  def rentals
    Rental.where(owner: self)
  end

  private

  def hash_id
    hashids = Hashids.new Rails.application.secrets.secret_key_base
    self.api_key = hashids.encode id
    save!
  end
end
