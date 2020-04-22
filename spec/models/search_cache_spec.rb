require 'rails_helper'

RSpec.describe SearchCache, type: :model do
  context "when a search_cache is valid" do
    it "is valid with all data" do
      search_cache = build(:search_cache)
      expect(search_cache).to be_valid
    end
  end

  context "when a search_cache is invalid" do
    it "is invalid without a word" do
      search_cache = build(:search_cache, word: " ")
      expect(search_cache).to_not be_valid
    end

    it "is invalid with a too short word" do
      search_cache = build(:search_cache, word: "a")
      expect(search_cache).to_not be_valid
    end

    it "is invalid with a too long word" do
      search_cache = build(:search_cache, word: "a" * 21)
      expect(search_cache).to_not be_valid
    end

    it "is invalid with something else except for an english word" do
      search_cache = build(:search_cache, word: "!$1&")
      expect(search_cache).to_not be_valid
    end

  end

end