class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # 選択モデル
    @model = params[:model]
    # 検索ワード
    @content = params[:content]
    # 検索条件
    @method = params[:method]

    # 選択したモデルに応じて検索を実行
    if @model  == "user"
      @records = User.search_for(@content, @method).page(params[:page])
    else
      @records = Post.search_for(@content, @method).page(params[:page])
    end
  end
end
