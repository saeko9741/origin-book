require 'net/http'
require 'json'
class WordbooksController < ApplicationController

	def new
			url = 'https://pixabay.com/api/?key=15371520-8deb9c8dd8bbb01f97ab99cc1&q=flower&pretty=true'
			uri = URI(url)
			# ただの文字列ではなくurlと認識させる？
			result = Net::HTTP.get(uri)
			# 検索の結果を格納？
			parsed_result = JSON.parse(result)
			# JSONからRubyのハッシュをつくる
			image_hits = parsed_result["hits"]
			# ハッシュの中のhits(key)で要素(value)を取得する
			@image_options = image_hits.map {|image| image["previewURL"]}
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
