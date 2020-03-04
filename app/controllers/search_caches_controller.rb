require 'net/http'
require 'json'
require 'rest-client'
#HTTPアクセスの為のライブラリ
require 'mechanize'

class SearchCachesController < ApplicationController
  def create
  	# if分岐
    word = params[:search_cache][:word]
### 翻訳API ###
  	translate_url = 'https://translation.googleapis.com/language/translate/v2?key=' + ENV['TRANSLATE_API_KEY']
  	payload = {
  	  q: word,
  	  target: 'ja',
  	  source: 'en'
  	}
  	header = {:content_type=>"text/html; charset=utf-8"}
    #APIにリクエストを送信
  	RestClient.post(translate_url, payload.to_json, header) { |response, request, result|
  	  case response.code
  	  when 200
  	    # 成功時の処理
  	    parse_response =  JSON.parse(response)
  	    definition = parse_response['data']['translations'][0]['translatedText']
  	  else
  	    # 失敗時の処理
  	    parse_response =  JSON.parse(response)
  	  end
### 翻訳API おわり ###

### 語源　スクレイピング ###
      agent = Mechanize.new
      # getメソッドを使って submit結果表示ページ内のリンクを全取得
      searched_page = agent.get('http://gogen-wisdom.hatenablog.com/search?q=' + word)
      when 404
      #page内2番目以降のh1要素のa要素を全取得(1番目はヘッダー内)
      entry_title_links = searched_page.search('h1[2] a')
      #クリックするurlを取得 (entry_title_linksの０番目のattributes内href内value値を取得)
      click_url = entry_title_links[0].attributes['href'].value
      click_page = searched_page.link_with(href: click_url).click
      #クラス名entry-content 内の2番目のpタグを指定
      origin_content = click_page.search('.entry-content p')[1]
      origin = origin_content.inner_text
### 語源　スクレイピング　おわり ###
      search_cache = SearchCache.new(searchcache_params)
      search_cache.definition = definition
      search_cache.origin = origin
      if search_cache.save
        #画像API挿入箇所
### 画像API ###
      image_url = 'https://pixabay.com/api/?key=' + ENV['IMAGE_API_KEY'] + '&q='+ word +'&pretty=true'
      # ただの文字列ではなくurlと認識させる？
      image_uri = URI(image_url)
      # 検索の結果を格納
      response = Net::HTTP.get(image_uri)
      # JSONからRubyのハッシュをつくる
      parsed_response = JSON.parse(response)
      # ハッシュの中のhits(key)で要素(value)を配列で取得
      word_image_hits = parsed_response["hits"]
      # 配列内のハッシュが配列の要素となり、previewURL(key)を元にurlを要素分繰り返し処理し、配列で変数に格納される
      word_image_options = word_image_hits.map {|image| image["previewURL"]}
      # 検索結果の始めから5番目まで入れる
      word_images = word_image_options.first(5)
### 画像API おわり###

      # imageを保存
      word_images.each do |word_image|
        image = Image.new
        image.search_cache_id = search_cache.id
        image.word_image = word_image
        image.save
      end

        #検索された単語に一致するレコードを取得
        applicable_searchcache = SearchCache.find_by(word: word)
        #検索された単語に一致するsearch_cachesのid
        redirect_to new_wordbook_path(search_cache_id: applicable_searchcache)
      else
        redirect_to root_path
      end
    }

  end
  private
  def searchcache_params
    params.require(:search_cache).permit(:word)
  end
end