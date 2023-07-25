class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, uniqueness: true, presence: true
  validates_presence_of :address
end
