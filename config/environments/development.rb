require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
  config.hosts.clear
end

#アプリケーションのひな型作成→ターミナル内に「rails new アプリケーション名」でENT アプリケーション名：sample_app
#ホストを許可→config/environments/development.rb内一番下のendの上に「config.hosts.clear」と記述
#モデルの作成→ターミナル内「rails g model モデル名」でENT モデル名：List
 #モデルのカラム作成→db/migrate/作成日時(数字の羅列)_create_lists.rb内に「title（タイトル）、body（本文）(どちらもカラム)」を
  #「t.データ型 :カラム名」の形式で「create_table :lists do |t|」の下に記述
 #テーブルの作成→ターミナルで「rails db:migrate」を実行
#コントローラーの作成(homesコントローラ)→ターミナル内で「rails g controller コントローラ名」実行 コントローラ名：homes
 #アクションの追加→app/controllers/homes_controller.rb内に「def top end」を３行に分けて記述
 #ルーティングを作成→config/routes.rb内に「HTTPメソッド 'URL' => 'コントローラ#アクション'」を記述
 #ビューを作成→app/viewsの「homes」右クリ→「New File」クリックで作成→ファイル名の変更は「homes」右クリで「Rename」 ファイル名：top.html.erb
#＊ターミナルで「rails g controller homes top」実行でコントローラー作成からビュー作成までできる
 #config/routes.rb内の「get 'homes/top'」を「get '/top' => 'homes#top'」に書き換える
#Listsコントローラを作成→ターミナルで「rails g controller lists new index show edit」実行

#投稿機能
#ルーティングを確認・追加→config/routes.rb内の「get 'lists/new'」の下に「post 'lists' => 'lists#create'」と記述
#form_withヘルパーでフォームを作成→app/views/lists/new.html.erb内に「<h1>新規投稿</h1>～<% end %>」まで新規追加
#コントローラーに記述を追加→app/controllers/lists_controller内の「def new」の下に「@list = List.new」を記述
 #app/views/lists/new.html.erb内の「<%= form_with model: List.new do |f| %>」を「<%= form_with model: @list do |f| %>」に変更
#保存機能追加・コントローラー変更→app/controllers/lists_controller内の「def new..end」の下に「def create..end」追加、一番下の「end」の上に「private..end」を追加
#厳密な記述への修正→app/views/lists/new.html.erb内の「<%= form_with model: @list do |f| %>」を「<%= form_with model: @list, url: '/lists', method: :post do |f| %>」に変更

#一覧画面の表示
#コントローラにindexアクションを追加→app/controllers/lists_controller.rb内の「def index..end」の「end」の上に「@lists = List.all」追記
#ビューファイルを記述→app/views/lists/index.html.e内に「<h1>投稿一覧</h1>～<% end %>」を新規追加
#Routingを設定→config/routes.rb内の「get 'lists/index'」を削除、代わりに「Rails.application.routes.draw do～end」を追加
#「rails s」で起動→/lists/newにアクセス→「タイトル:test1」「本文:title1」で投稿押す→２回やる→/listsにアクセスして２つづつ表示されたら完了

#詳細画面を作る
#ルーディングの追加→config/routes.rb内の「get 'lists/show'」を削除、代わりに「Rails.application.routes.draw do～end」を追加
#showアクションを作成→app/controllers/lists_controller.rb内の「def show..end」の「end」の上に「 @list = List.find(params[:id])」追記
#show.html.erbを作成・ビューに記述→app/views/lists/show.html.erb内に「<h2>タイトル</h2>～<p><%= @list.body %></p>」記述
#indexにshowへのリンクを作成→app/views/lists/index.html.erb内の「<span></span>」内を変更
#ルーティング(名前付きルート設定)→config/routes.rb内の「get 'lists/:id' => 'lists#show'」を「get 'lists/:id' => 'lists#show', as: 'list'」に書き換え
 #indexのlink_toを変更→app/views/lists/index.html.erb内の「<span></span>」内を「 <%= link_to list.title, list_path(list.id) %> 」に変更
 #createアクションのredirect_toを変更→app/controllers/lists_controller.rb内の「def create..end」内の「redirect_to '/top'」を「redirect_to list_path(list.id) 」に変更

#編集機能を作る
#編集フォームを作成
 #コントローラ→app/controllers/lists_controller.rb内の「def edit..end」内に「@list = List.find(params[:id])」追加
 #ビュー→app/views/lists/edit.html.erb内の「<h1>編集画面</h1>～<% end %>」に書き換え
 #ルーティング→config/routes.rb内の「get 'lists/edit'」削除、「Rails.application.routes.draw do～end」を削除したところに追加
 #更新機能を追加
#コントローラ→app/controllers/lists_controller.rb内に「def edit..end」の下に「def update..end」を追加
#ルーティング→ config/routes.rb内の「get 'lists/:id/edit' => 'lists#edit', as: 'edit_list'」の下に「patch 'lists/:id' => 'lists#update', as: 'update_list'」追加
#ビュー(記述追加)→app/views/lists/edit.html.erb内の「%= form_with model: @list do |f| %>」を
 #「<%= form_with model: @list, url: update_list_path(@list.id), method: :patch do |f| %>」に書き換え
#詳細画面に編集画面へのリンクを追加→app/views/lists/show.html.erb内の一番下に「<%= link_to "編集", edit_list_path(@list.id) %>」追加

#画像投稿機能を作る
#ActiveStorageをインストール→ターミナルで「rails active_storage:install」実行、そのあと「rails db:migrate」実行
#モデルに記述を追加→app/models/list.rb内に「class List < ApplicationRecord～end」記述
#画像を投稿できるようにする
 #ビューに記述を追加→app/views/lists/new.html.erb内に「<h4>画像</h4><%= f.file_field :image, accept: "image/*" %>」追加(<%= f.text_area :body %>の下に記述)
 #コントローラ(値を受け取る許可)→app/controllers/lists_controller.rb内の「def list_params..end」内「(:title, :body）」に「, :image」追加
#ビューで画像を表示
 #一覧画面(index)→app/views/lists/index.html.erb内「<% end %>」の上に「<p>画像</p><%= image_tag list.image, size: "200x200" %>」追加
  #エラーの回避→app/views/lists/index.html内「<p>画像</p>」の下に「<% if list.image.attached? %>」と
  #「<%= image_tag list.image, size: "200x200" %>」の下に「<% else %>～<% end %>」追加
 #詳細画面(show)→app/views/lists/show.html.erb内の「<p><%= @list.body %></p>」の下に「<h2>画像</h2>～<% end %>」追加