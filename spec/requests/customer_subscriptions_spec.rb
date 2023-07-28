require 'rails_helper'

RSpec.describe "CustomerSubscriptions API calls" do
  describe "POST /api/v1/customer_subscriptions" do
    it "passed valid customer email and subscription title, is created" do
      customer = create(:customer)
      subscription = create(:subscription)

      customer_subscription_params = {
        "customer_email": customer.email,
        "subscription_title": subscription.title
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce).to have_key(:message)
      expect(formatted_responce[:message]).to eq("Succesfully created customer subscription")

      expect(customer.subscriptions).to include(subscription)
      expect(subscription.customers).to include(customer)
    end

    it "if customer email passed does not pertain to a customer, error is sent" do
      customer = create(:customer)
      subscription = create(:subscription)

      customer_subscription_params = {
        "customer_email": "123@happyplace.com",
        "subscription_title": subscription.title
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce).to have_key(:error)
      expect(formatted_responce[:error]).to eq("Customer not found with email input")
    end

    it "if subscription title passed does not pertain to a subscription, error is sent" do
      customer = create(:customer)
      subscription = create(:subscription)

      customer_subscription_params = {
        "customer_email": customer.email,
        "subscription_title": "subscription.title"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce).to have_key(:error)
      expect(formatted_responce[:error]).to eq("Subscription not found with title input")
    end
  end

  describe "PATCH /api/v1/customer_subscriptions_cancel" do
    it "passed valid customer email and subscription title, status is canceled" do
      customer = create(:customer)
      subscription = create(:subscription)

      customer_subscription_params = {
        "customer_email": customer.email,
        "subscription_title": subscription.title
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

      patch "/api/v1/customer_subscriptions_cancel", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce).to have_key(:message)
      expect(formatted_responce[:message]).to eq("Succesfully canceled customer subscription")

      expect(customer.customer_subscriptions.first.status).to eq("cancelled")
    end
  end
end