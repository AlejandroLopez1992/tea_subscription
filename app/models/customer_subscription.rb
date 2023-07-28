class CustomerSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :customer
  enum status: %w(active cancelled)

  def cancel
    self.status = 1
  end
end