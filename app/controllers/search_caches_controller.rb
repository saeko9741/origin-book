require 'net/http'
require 'json'
#HTTPアクセスの為のライブラリ
require 'rest-client'
require 'mechanize'

class SearchCachesController < ApplicationController
  def create
    searched_word = params[:search_cache][:word]
    if user_signed_in?
      applicable_wordbook = current_user.wordbooks.find_by(word: searched_word)
      #ログインユーザーのwordbookに検索単語がある場合
      if applicable_wordbook.present?
        redirect_to edit_wordbook_path(applicable_wordbook.id)
        #wordbook内に単語があれば処理を終わらせる
        return
      end
    end
    #ログインしていないまたは、ログインユーザーのwordbookに検索単語がない場合
    applicable_searchcache = SearchCache.find_by(word: searched_word)
    #search_cacheに検索された単語がなければnilになり、翻訳・語源・画像を取得する
    if applicable_searchcache.nil?
### 翻訳API ###
      translate_url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['TRANSLATE_API_KEY']}"
      payload = {
        q: searched_word,
        target: 'ja',
        source: 'en'
      }
      header = {:content_type=>"text/html; charset=utf-8"}
      #APIにリクエストを送信
      RestClient.post(translate_url, payload.to_json, header) do |response, request, result|
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
### スクレイピング ###
        origin = scrape_origin(searched_word)
        #単語、意味、語源を保存
        @search_cache = SearchCache.new(searchcache_params)
        @search_cache.definition = definition
        # 正しく検索がヒットしない場合 "「語源の広場」へようこそ。" と表示される
        if origin.blank? or origin == "『語源の広場』へようこそ。"
          origin = "語源を表示できませんでしたが、調べてみましょう！"
        end
        @search_cache.origin = origin
        if @search_cache.save
### 画像API ###
          image_url = "https://pixabay.com/api/?key=#{ENV['IMAGE_API_KEY']}&q=#{searched_word}"
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
          if word_images.present?
            word_images.each do |word_image|
              image = Image.new
              image.search_cache_id = @search_cache.id
              image.word_image = word_image
              image.save!
            end
          else
            image = Image.new
            image.search_cache_id = @search_cache.id
            image.word_image = ""
            image.save!
          end
          #検索された単語に一致するレコードを取得(スコープ内再定義)
          applicable_searchcache = SearchCache.find_by(word: searched_word)
          #検索された単語に一致するsearch_cachesのid
          redirect_to new_wordbook_path(search_cache_id: applicable_searchcache)
        else
          render 'homes/top'
        end
      end
    else #search_cache内に単語があった場合
      redirect_to new_wordbook_path(search_cache_id: applicable_searchcache)
    end
  end

  private
  def searchcache_params
    params.require(:search_cache).permit(:word)
  end

  def scrape_origin(word)
    agent = Mechanize.new
    begin
    searched_page = agent.get("http://gogen-wisdom.hatenablog.com/search?q=#{word}")
    rescue => error
    end
    if searched_page.present?
      #page内2番目以降のh1要素のa要素を全取得(1番目はヘッダー内)
      entry_title_links = searched_page.search('h1[2] a')
      #クリックするurlを取得 (entry_title_linksの０番目のattributes内href内value値を取得)
      click_url = entry_title_links[0].attributes['href'].value
      click_page = searched_page.link_with(href: click_url).click
      origin = ""
      origin_contents = click_page.search('.entry-content p')
      origin_contents.each do |origin_content|
        next if origin_content.inner_text.blank?
          if origin_content.inner_text.include?("語")
            return origin_content.inner_text
            break
          end
      end
    end
  end
end
