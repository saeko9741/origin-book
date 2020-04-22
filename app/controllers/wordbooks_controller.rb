class WordbooksController < ApplicationController
before_action :set_wordbook, only: [:edit, :update, :destroy]

	def new
		@wordbook = Wordbook.new
		@search_cache = SearchCache.find(params[:search_cache_id])
		@images = Image.where(search_cache_id: params[:search_cache_id])
	end
	def index
		@wordbooks = current_user.wordbooks
		# @wordbooks = Wordbook.where(user_id: current_user.id)
	end
	def create
		@wordbook = Wordbook.new(wordbook_params)
		@wordbook.user_id = current_user.id
		image = Image.find_by(search_cache_id: params[:search_cache_id])
		if image.word_image.empty?
			@wordbook.image_id = image.id
		end
		if @wordbook.save
			redirect_to wordbooks_path
		else
			@search_cache = SearchCache.find(params[:search_cache_id])
			@images = Image.where(search_cache_id: params[:search_cache_id])
			render "new"
		end
	end
	def edit
		@wordbook.user_id = current_user.id
		@search_cache = SearchCache.find_by(word: @wordbook.word)
		@images = Image.where(search_cache_id: @search_cache.id)
	end
	def update
		@wordbook.user_id = current_user.id
		if params[:wordbook][:image_id] == "0"
			params[:wordbook].delete(:image_id)
		else
			@wordbook.my_image  = nil
		end
		if @wordbook.update(wordbook_params)
			redirect_to wordbooks_path
		else
			render "edit"
		end
	end
	def destroy
		@wordbook.destroy
		redirect_to wordbooks_path
	end
	private
	def wordbook_params
	  params.require(:wordbook).permit(:word, :meaning, :origin, :image_id, :my_image)
	  # definition, origin必要か
	end
	def set_wordbook
		@wordbook = Wordbook.find(params[:id])
	end
end
