require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :subscription }
  end

  describe "validations" do
    it { should define_enum_for(:status).with_values([:active, :cancelled]) }
  end

  describe "instance methods" do
    describe "cancel" do
      it "changes status from active to cancelled" do
        customer = create(:customer)
        subscription = create(:subscription)
        customer_subscription = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
        customer_subscription.save
        
        expect(customer_subscription.status).to eq("active")

        customer_subscription.cancel

        expect(customer_subscription.status).to eq("cancelled")
      end
    end
  end
end
