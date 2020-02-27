require 'net/http'
require 'json'
class WordbooksController < ApplicationController

	def new
  	########## 画像API ###############################################################
  	word = params[:word]
		url = 'https://pixabay.com/api/?key=15371520-8deb9c8dd8bbb01f97ab99cc1&q='+ word +'&pretty=true'
		uri = URI(url)
		# ただの文字列ではなくurlと認識させる？
		result = Net::HTTP.get(uri)
		# 検索の結果を格納？
		parsed_result = JSON.parse(result)
		# JSONからRubyのハッシュをつくる
		image_hits = parsed_result["hits"]
		# ハッシュの中のhits(key)で要素(value)を配列で取得
		@image_options = image_hits.map {|image| image["previewURL"]}
		# 配列内のハッシュが配列の要素となり、previewURL(key)を元にurlを要素分繰り返し処理し、配列で変数に格納される

		############################################################################

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
