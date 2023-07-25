class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer
  validates_presence_of :title
  validates_numericality_of :price, greater_than: 0
  enum status: %w(active cancelled)
  enum frequency: %w(weekly monthly quarterly yearly)
end
