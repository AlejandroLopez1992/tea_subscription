class CustomerSubscriptionSerializer
  include JSONAPI::Serializer
  
  belongs_to :customer
  belongs_to :subscription
end