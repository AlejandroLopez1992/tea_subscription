class TeaSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :temperature, :brew_time, :created_at, :updated_at

  has_many :subscription_teas
  has_many :subscriptions, through: :subscription_teas
end