#HTTPアクセスの為のライブラリ
require 'rest-client'
# スクレイピング用ライブラリ
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
      @search_cache = SearchCache.new(searchcache_params)
      # バリデーションに引っかかればトップへ
      return render 'homes/top' unless @search_cache.valid?
            @search_cache.register!
    end
    applicable_searchcache = SearchCache.find_by(word: searched_word)
    #検索された単語に一致するsearch_cachesのid
    redirect_to new_wordbook_path(search_cache_id: applicable_searchcache)
  end

  private
  def searchcache_params
    params.require(:search_cache).permit(:word)
  end

end
