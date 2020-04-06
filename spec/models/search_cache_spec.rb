require 'rails_helper'

RSpec.describe SearchCache, type: :model do
  context "when a search_cache is valid" do
    it "is valid with all data" do
      search_cache = build(:search_cache)
      expect(search_cache).to be_valid
    end
  end

end