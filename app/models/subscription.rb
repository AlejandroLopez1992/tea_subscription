class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer
  validates_presence_of :title
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :status, greater_than: 0, less_than: 3
  validates_numericality_of :frequency, greater_than: 0
end
