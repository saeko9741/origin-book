require 'rails_helper'

RSpec.describe User, type: :model do
  context "when a user is valid" do
    it "is valid with all data" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
  
  context "when a user is invalid" do
    it "is invalid without a name" do
      user = build(:user, name: " ")
      expect(user).to_not be_valid
    end

    it "is invalid with a too short name" do
      user = build(:user, name: "a")
      expect(user).to_not be_valid
    end

    it "is invalid with a too long name" do
      user = build(:user, name: "a" * 21)
      expect(user).to_not be_valid
    end

    it "is invalid without an email" do
      user = build(:user, email: " ")
      expect(user).to_not be_valid
    end

    it "is invalid with without a password" do
      password = " "
      user = build(:user, password: password, password_confirmation: password)
      expect(user).to_not be_valid
    end

    it "is invalid with a different password" do
      user = build(:user, password: "aaa", password_confirmation: "bbb")
      expect(user).to_not be_valid
    end

    it "is invalid with a too short password" do
      user = build(:user, password: "a", password_confirmation: "a")
      expect(user).to_not be_valid
    end

  end
end
