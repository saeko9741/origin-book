class WordbooksController < ApplicationController

	def new
		@search_cache = SearchCache.find(params[:search_cache_id])
		@images = Image.where(search_cache_id: params[:search_cache_id])
	end
	def index
		
	end
	def crate
		
	end
	def edit
		
	end
	def update
		
	end
	def destory
		
	end
end
