
class HomesController < ApplicationController
  def top
  	@search_cache = SearchCache.new
  end

  def about
  end
end
