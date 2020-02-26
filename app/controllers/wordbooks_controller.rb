require 'net/http'
require 'json'
class WordbooksController < ApplicationController

	def new
			url = 'https://pixabay.com/api/?key=15371520-8deb9c8dd8bbb01f97ab99cc1&q=flower&pretty=true'
			uri = URI(url)
			# ただの文字列ではなくurlと認識させる？
			response = Net::HTTP.get(uri)
			# 検索の結果を格納？
			parsed_response = JSON.parse(response)
			# JSONからRubyのハッシュをつくる
			word_images = parsed_response["hits"]
			@word_image_options = word_images.map {|image| image["previewURL"]}
			binding.pry

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
