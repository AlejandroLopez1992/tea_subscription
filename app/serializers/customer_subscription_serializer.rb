class CustomerSubscriptionSerializer
  include JSONAPI::Serializer

  def created
    {
      "message": "Succesfully created customer subscription"
    }
  end
end