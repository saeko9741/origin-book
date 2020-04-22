require 'rails_helper'

RSpec.describe User, type: :model do
  context "when a user is valid" do
    it "is valid with all data" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
  
  # context "when a user is invalid" do
  #   it "is invalid without a name" do
  #   end

  #   it "is invalid with a too short name" do
  #   end

  #   it "is invalid with a too long name" do
  #   end

  #   it "is invalid without an email" do
  #   end

  #   it "is"
  # end
end
