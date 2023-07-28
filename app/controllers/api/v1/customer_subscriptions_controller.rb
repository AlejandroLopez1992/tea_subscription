class Api::V1::CustomerSubscriptionsController < ApplicationController
rescue_from NoMethodError, with: :not_found

  def create
    customer_id = find_customer_id(customer_subscription_params)
    subscription_id = find_subscription_id(customer_subscription_params)
    customer_subscription = CustomerSubscription.new(customer_id: customer_id, subscription_id: subscription_id)
    if customer_subscription.save
      render json: CustomerSubscriptionSerializer.new(customer_subscription).created, status: 201
    end
  end

  def update
    customer_id = find_customer_id(customer_subscription_params)
    subscription_id = find_subscription_id(customer_subscription_params)
    customer_subscription = CustomerSubscription.find_by(customer_id: customer_id, subscription_id: subscription_id)
    customer_subscription.cancel
    if customer_subscription.save
      render json: CustomerSubscriptionSerializer.new(customer_subscription).cancelled, status: 200
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

    def not_found(exception)
      if exception.message.include?("customer_id")
        render json: ErrorSerializer.new(exception).customer_not_found, status: 404
      else
        render json: ErrorSerializer.new(exception).subscription_not_found, status: 404
      end
    end
end