class CustomerSubscriptionSerializer
  include JSONAPI::Serializer

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