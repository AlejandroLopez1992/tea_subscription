class RemoveCustomerFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :subscriptions, :customer, null: false, foreign_key: true
  end
end
