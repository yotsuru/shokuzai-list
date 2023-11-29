require "test_helper"

class Users::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_genres_new_url
    assert_response :success
  end

  test "should get index" do
    get users_genres_index_url
    assert_response :success
  end

  test "should get show" do
    get users_genres_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_genres_edit_url
    assert_response :success
  end
end
