class WordbooksController < ApplicationController

	def new
		@wordbook = Wordbook.new
		@search_cache = SearchCache.find(params[:search_cache_id])
		@images = Image.where(search_cache_id: params[:search_cache_id])
	end
	def index
		@wordbooks = Wordbook.where(user_id: current_user.id)
	end
	def create
		wordbook = Wordbook.new(wordbook_params)
		wordbook.user_id = current_user.id
		if wordbook.save
			redirect_to wordbooks_path
		else
			@search_cache = SearchCache.find(params[:search_cache_id])
			@images = Image.where(search_cache_id: params[:search_cache_id])
			render "new"
		end
	end
	def edit
		@wordbook = Wordbook.find(params[:id])
	end
	def update
		
	end
	def destory
		
	end
	private
	def wordbook_params
	  params.require(:wordbook).permit(:word, :meaning, :origin, :image_id)
	  # definition, origin必要か
	end
end
