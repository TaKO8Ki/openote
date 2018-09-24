# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/send_user_like_articles
  def send_user_like_articles
    UserMailer.send_user_like_articles
  end

end
