class CustomerSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :customer
  enum status: %w(active cancelled)
end