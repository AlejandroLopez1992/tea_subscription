class Tea < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :description
  validates_numericality_of :temperature, greater_than: 0, less_than: 250
  validates_numericality_of :brew_time, greater_than: 0
end
