class UserMailer < ApplicationMailer
  default from:       "メールテスト運営局 <greenbarleytea@gmail.com>",
              reply_to: "greenbarleytea@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_user_like_articles.subject
  #
  def send_user_like_articles(user)
    @user = user
    mail( to: user.email, subject: '会員情報が更新されました。')
  end

end
