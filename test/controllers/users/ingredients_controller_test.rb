require "test_helper"

class Users::IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_ingredients_new_url
    assert_response :success
  end

  test "should get show" do
    get users_ingredients_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_ingredients_edit_url
    assert_response :success
  end
end
