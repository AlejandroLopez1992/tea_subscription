class CustomerSubscriptionSerializer
  include JSONAPI::Serializer
  attributes :status, :customer_id, :subscription_id, :subscription

  def created
    {
      "message": "Succesfully created customer subscription"
    }
  end

  def cancelled
    {
      "message": "Succesfully cancelled customer subscription"
    }
  end
end