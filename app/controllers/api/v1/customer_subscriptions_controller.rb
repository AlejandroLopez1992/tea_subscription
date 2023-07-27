class Api::V1::CustomerSubscriptionsController < ApplicationController

  def create
    customer_id = find_customer_id(customer_subscription_params)
    subscription_id = find_subscription_id(customer_subscription_params)
    customer_subscription = CustomerSubscription.new(customer_id: customer_id, subscription_id: subscription_id)
    if customer_subscription.save
      require 'pry'; binding.pry
      render json: CustomerSubscriptionSerializer.new(customer_subscription).created, status: 201
    end
  end

  private

    def customer_subscription_params
      params.require(:customer_subscription).permit(:customer_email, :subscription_title)
    end

    def find_customer_id(customer_subscription_params)
      customer_id = Customer.find_by(email: customer_subscription_params[:customer_email]).id
    end

    def find_subscription_id(customer_subscription_params)
      subscription_id = Subscription.find_by(title: customer_subscription_params[:subscription_title]).id
    end
end