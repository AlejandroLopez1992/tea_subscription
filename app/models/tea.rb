class Tea < ApplicationRecord
  has_many :subscription_teas
  has_many :subscriptions, through: :subscription_teas
  validates_presence_of :title
  validates_presence_of :description
  validates_numericality_of :temperature, greater_than: 0, less_than: 250
  validates_numericality_of :brew_time, greater_than: 0
end
