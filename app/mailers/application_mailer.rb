class ApplicationMailer < ActionMailer::Base
  default from:       "メールテスト運営局",
              reply_to: "greenbarleytea@gmail.com"
  layout 'mailer'
end
