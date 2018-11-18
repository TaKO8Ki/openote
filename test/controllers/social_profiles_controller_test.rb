require 'test_helper'

class SocialProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get social_profiles_destroy_url
    assert_response :success
  end

end
