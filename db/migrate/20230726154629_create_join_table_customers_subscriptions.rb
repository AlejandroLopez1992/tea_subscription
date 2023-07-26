class CreateJoinTableCustomersSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :customers, :subscriptions do |t|

      t.timestamps
    end
  end
end
