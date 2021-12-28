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

  test "should get login" do
    get signup_path
    assert_response :success
    assert_select "title", "ログイン | Time Keeper"
  end


  test "link to statictics and home" do
    get root_url
    assert_select "a[href=?]", statictics_path
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", contact_path

  end
end
