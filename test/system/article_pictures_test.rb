require "application_system_test_case"

class ArticlePicturesTest < ApplicationSystemTestCase
  setup do
    @article_picture = article_pictures(:one)
  end

  test "visiting the index" do
    visit article_pictures_url
    assert_selector "h1", text: "Article Pictures"
  end

  test "creating a Article picture" do
    visit article_pictures_url
    click_on "New Article Picture"

    fill_in "Picture", with: @article_picture.picture
    fill_in "User", with: @article_picture.user_id
    click_on "Create Article picture"

    assert_text "Article picture was successfully created"
    click_on "Back"
  end

  test "updating a Article picture" do
    visit article_pictures_url
    click_on "Edit", match: :first

    fill_in "Picture", with: @article_picture.picture
    fill_in "User", with: @article_picture.user_id
    click_on "Update Article picture"

    assert_text "Article picture was successfully updated"
    click_on "Back"
  end

  test "destroying a Article picture" do
    visit article_pictures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Article picture was successfully destroyed"
  end
end
