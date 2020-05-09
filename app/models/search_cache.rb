class SearchCache < ApplicationRecord
  after_create :bulk_create_images!
  has_many :images
  validates :word, presence: true, length: {in: 2..20}, format: { with: /\A[a-zA-Z]+\z/ }

  def register!
    self.origin = scrape_origin
    if origin.blank? or origin == "『語源の広場』へようこそ。"
      self.origin = "語源を表示できませんでしたが、調べてみましょう！"
    end
    self.definition = fetch_definition
    save!
  end

  def bulk_create_images!
    # 画像API
    word_images = fetch_images(word)
    if word_images.present?
      word_images.each do |word_image|
        images.create!(word_image: word_image)
      end
    else
      images.create!(word_image: '')
    end
  end

  private
  def scrape_origin
    agent = Mechanize.new
    begin
      searched_page = agent.get("http://gogen-wisdom.hatenablog.com/search?q=#{self.word}")
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

  def fetch_definition
      translate_url = "https://translation.googleapis.com/language/translate/v2?key=#{ENV['TRANSLATE_API_KEY']}"
      payload = {
        q: word,
        target: 'ja',
        source: 'en'
      }
      header = {:content_type=>"text/html; charset=utf-8"}
      #APIにリクエストを送信
      response = RestClient.post(translate_url, payload.to_json, header)
      case response.code
      when 200
        # 成功時の処理
        parse_response =  JSON.parse(response)
        parse_response['data']['translations'][0]['translatedText']
      else
        # 失敗時の処理
        parse_response =  JSON.parse(response)
        raise "error"
      end
  end

  def fetch_images(word)
    response = RestClient.get "https://pixabay.com/api/?key=#{ENV['IMAGE_API_KEY']}&q=#{word}"
    # JSONからRubyのハッシュをつくる
    parsed_response = JSON.parse(response)
    # ハッシュの中のhits(key)で要素(value)を配列で取得
    word_image_hits = parsed_response["hits"]
    # 配列内のハッシュが配列の要素となり、previewURL(key)を元にurlを要素分繰り返し処理し、配列で変数に格納される
    word_image_options = word_image_hits.map {|image| image["previewURL"]}
    # 検索結果の始めから5番目まで入れる
    word_image_options.first(5)
  end
end