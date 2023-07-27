class ErrorSerializer
  include JSONAPI::Serializer

  def customer_not_found
    {
      "error": "Customer not found with email input"
    }
  end

  def subscription_not_found
    {
      "error": "Subscription not found with title input"
    }
  end
end