class CustomerSubscriptionSerializer
  include JSONAPI::Serializer

  def created
    {
      "Succesfully created customer subscription"
    }
  end
end