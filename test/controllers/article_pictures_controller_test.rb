require 'test_helper'

class ArticlePicturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_picture = article_pictures(:one)
  end

  test "should get index" do
    get article_pictures_url
    assert_response :success
  end

  test "should get new" do
    get new_article_picture_url
    assert_response :success
  end

  test "should create article_picture" do
    assert_difference('ArticlePicture.count') do
      post article_pictures_url, params: { article_picture: { picture: @article_picture.picture, user_id: @article_picture.user_id } }
    end

    assert_redirected_to article_picture_url(ArticlePicture.last)
  end

  test "should show article_picture" do
    get article_picture_url(@article_picture)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_picture_url(@article_picture)
    assert_response :success
  end

  test "should update article_picture" do
    patch article_picture_url(@article_picture), params: { article_picture: { picture: @article_picture.picture, user_id: @article_picture.user_id } }
    assert_redirected_to article_picture_url(@article_picture)
  end

  test "should destroy article_picture" do
    assert_difference('ArticlePicture.count', -1) do
      delete article_picture_url(@article_picture)
    end

    assert_redirected_to article_pictures_url
  end
end
