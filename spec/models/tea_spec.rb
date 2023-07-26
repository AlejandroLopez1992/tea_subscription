require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "relationships" do
    it { should have_many :subscription_teas }
    it { should have_many(:subscriptions).through(:subscription_teas) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:temperature).is_less_than(250) }
    it { should validate_numericality_of(:temperature).is_greater_than(0) }
    it { should validate_numericality_of(:brew_time).is_greater_than(0) }
  end
end
