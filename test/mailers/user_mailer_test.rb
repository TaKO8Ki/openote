require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "send_user_like_articles" do
    mail = UserMailer.send_user_like_articles
    assert_equal "Send user like articles", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
