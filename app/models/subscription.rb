class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscription_teas
  validates_presence_of :title
  validates_numericality_of :price, greater_than: 0
  enum frequency: %w(weekly monthly quarterly yearly)
end
