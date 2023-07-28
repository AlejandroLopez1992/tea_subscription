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
      expect(formatted_responce[:message]).to eq("Succesfully cancelled customer subscription")

      expect(customer.customer_subscriptions.first.status).to eq("cancelled")
    end

    it "if customer email passed does not pertain to a customer, error is sent" do
      customer = create(:customer)
      subscription = create(:subscription)

      customer_subscription_params = {
        "customer_email": "123@happyplace.com",
        "subscription_title": subscription.title
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customer_subscriptions_cancel", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

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

      patch "/api/v1/customer_subscriptions_cancel", headers: headers, params: JSON.generate(customer_subscription: customer_subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce).to have_key(:error)
      expect(formatted_responce[:error]).to eq("Subscription not found with title input")
    end
  end

  describe "GET /api/v1/customer_subscriptions" do
    it "sends all customer_subscriptions within a key of data for customer based on passed email" do
      customer = create(:customer)
      subscription = create(:subscription)
      customer_subscription_1 = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
      customer_subscription_1.save
      customer_subscription_2 = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
      customer_subscription_2.save
      customer_subscription_1.cancel
      customer_subscription_1.save

      customer_subscription_params = {
        "customer_email": customer.email
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      get '/api/v1/customer_subscriptions', headers: headers, params: {customer_subscription: customer_subscription_params}
      expect(response).to be_successful
  
      customer_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(customer_subscriptions[:data].count).to eq(2)
  
      customer_subscriptions[:data].each do |customer_subscription|
        expect(customer_subscription).to have_key(:id)
        expect(customer_subscription[:id]).to be_a(String)

        expect(customer_subscription).to have_key(:type)
        expect(customer_subscription[:type]).to be_a(String)
        expect(customer_subscription[:type]).to eq("customer_subscription")

        expect(customer_subscription).to have_key(:attributes)
        expect(customer_subscription[:attributes]).to be_a(Hash)
  
        expect(customer_subscription[:attributes]).to have_key(:status)
        expect(customer_subscription[:attributes][:status]).to be_a(String)
  
        expect(customer_subscription[:attributes]).to have_key(:customer_id)
        expect(customer_subscription[:attributes][:customer_id]).to be_a(Integer)
  
        expect(customer_subscription[:attributes]).to have_key(:subscription_id)
        expect(customer_subscription[:attributes][:subscription_id]).to be_a(Integer)
  
        expect(customer_subscription[:attributes]).to have_key(:subscription)
        expect(customer_subscription[:attributes][:subscription]).to be_a(Hash)
  
        expect(customer_subscription[:attributes][:subscription]).to have_key(:id)
        expect(customer_subscription[:attributes][:subscription][:id]).to be_a(Integer)
  
        expect(customer_subscription[:attributes][:subscription]).to have_key(:title)
        expect(customer_subscription[:attributes][:subscription][:title]).to be_a(String)
  
        expect(customer_subscription[:attributes][:subscription]).to have_key(:price)
        expect(customer_subscription[:attributes][:subscription][:price]).to be_a(Integer)
  
        expect(customer_subscription[:attributes][:subscription]).to have_key(:frequency)
        expect(customer_subscription[:attributes][:subscription][:frequency]).to be_a(String)

        expect(customer_subscription[:attributes][:subscription]).to have_key(:created_at)
        expect(customer_subscription[:attributes][:subscription][:created_at]).to be_a(String)

        expect(customer_subscription[:attributes][:subscription]).to have_key(:updated_at)
        expect(customer_subscription[:attributes][:subscription][:updated_at]).to be_a(String)
      end
    end

    it "if customer email passed does not pertain to a customer, error is sent" do
      customer = create(:customer)
      subscription = create(:subscription)
      customer_subscription_1 = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
      customer_subscription_1.save
      customer_subscription_2 = CustomerSubscription.new(customer_id: customer.id, subscription_id: subscription.id)
      customer_subscription_2.save
      customer_subscription_1.cancel
      customer_subscription_1.save

      customer_subscription_params = {
        "customer_email": "randomemail@email.com"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      get '/api/v1/customer_subscriptions', headers: headers, params: {customer_subscription: customer_subscription_params}
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      formatted_responce = JSON.parse(response.body, symbolize_names: true)

      expect(formatted_responce).to be_a(Hash)
      expect(formatted_responce).to have_key(:error)
      expect(formatted_responce[:error]).to eq("Customer not found with email input")
    end
  end
end