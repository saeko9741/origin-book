require 'mechanize'

class HomesController < ApplicationController
  def top
  	@search_cache = SearchCache.new
  end

  def about
  	agent = Mechanize.new
  	searched_page = agent.get('http://gogen-wisdom.hatenablog.com/search?q=stress')
  	# getメソッドを使って submit結果表示ページ内のリンクを全取得
  	entry_title_links = searched_page.search('h1[2] a')
  	#page内2番目以降のh1要素のa要素を全取得(1番目はヘッダー内)
  	click_url = entry_title_links[0].attributes['href'].value
  	#クリックするurlを取得 (entry_title_linksの０番目のattributes内href内value値を取得)
  	click_page = searched_page.link_with(href: click_url).click
  	origin_content = click_page.search('.entry-content p')[1]
  	#クラス名entry-content 内の2番目のpタグを指定
  	origin = origin_content.inner_text
  	binding.pry

  end
end
