class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :address
end
