class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :frequency, :created_at, :updated_at

  has_many :subscription_teas
  has_many :teas, through: :subscription_teas
end