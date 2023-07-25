require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should belong_to :tea }
    it { should belong_to :customer }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:status).is_in(1..2) }
    it { should validate_numericality_of(:frequency).is_greater_than(0) }
  end
end
