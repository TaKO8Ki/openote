class StaticsController < ApplicationController
  def privacy_policy
    @title = "プライバシーポリシー"
  end

  def contact
    @title = "お問い合わせ"
  end

  def rules
    @title = "利用規約"
  end

  def about
    @title = "とは？"
  end
end
