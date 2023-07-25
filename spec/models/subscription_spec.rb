require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should belong_to :tea }
    it { should belong_to :customer }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should define_enum_for(:status).with_values([:active, :cancelled]) }
    it { should define_enum_for(:frequency).with_values([:weekly, :monthly, :quarterly, :yearly]) }
  end
end