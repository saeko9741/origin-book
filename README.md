# ORIGIN BOOK

[![logo](https://user-images.githubusercontent.com/58896213/76677958-17ee5e00-6617-11ea-8dcf-7abb1da8358b.jpg)](http://13.115.157.168)  
[ORIGIN BOOK](http://13.115.157.168/)



名前の由来は、**ORIGIN(語源) + WORD BOOK(単語帳)** です。  
英単語を検索した時に、ただ意味を調べるのではなく、単語の **「語源」**と**「画像」** も調べることができます。  
調べた単語を画像でイメージとして覚えやすく、語源を知ることで忘れにくく、楽しく学習するツールになることを目標に制作しました。



## Demo  
新規登録またはログイン後のMY WORDBOOK (保存した単語一覧)表示画面

![image](https://user-images.githubusercontent.com/58896213/77268705-1a714780-6cea-11ea-8144-ca914d235430.png)



## Features

* **英単語検索機能**  
検索後「語源」「画像」「意味」が表示されます。ログイン、新規登録せずに検索は行えます。

1. 「語源」
[語源の広場](http://gogen-wisdom.hatenablog.com/)より検索した結果をスクレイピングして表示します。

2. 「画像」
pixabay APIを用いて検索された英単語の画像を5枚表示します。

3. 「意味」
Google stanslation APIを用いて検索された英単語の日本語訳を表示します。



* **ユーザー登録機能**  
検索結果後にサインアップまたはログインすることで、MY WORDBOOK (MY単語帳)として登録することができます。

* **MY WORDBOOK (MY単語帳)作成機能**  
MY WORDBOOKの単語は「意味」「語源」「画像」すべて編集・削除が可能であり、検索時に表示された画像の他にも任意の画像を登録することも可能です。



* **その他機能**  
一度検索された英単語は自動的に保存されるため、二回目に検索された場合はすぐに検索結果を表示することが可能になります。


## Requirement  
* Ruby 2.5.7
* Rails 5.2.4.1
* gem devise
* gem bootstrap
* gem jquery-rails
* gem refile
* gem refile-mini_magic
* gem mechanize
* gem rest-client


## API
[Google translation API](https://cloud.google.com/translate/docs?hl=ja)  
[pixabay API](https://pixabay.com/api/docs/)


## Note
* 語源に関しては、[語源の広場](http://gogen-wisdom.hatenablog.com/)
様から引用させていただいております。  
* DMM WEBCAMP ポートフォリオ作品 2020年3月



## Author

Saeko