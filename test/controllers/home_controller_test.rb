require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "トップページ | Time Keeper"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "お問い合わせ | Time Keeper"
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", "ユーザー登録 | Time Keeper"
  end
end
