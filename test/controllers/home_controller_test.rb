require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "div", "Hello World"
    assert_select "title", "トップページ | Time Keeper"
  end

  test "link to statictics and home" do
    get root_url
    assert_select "a[href=?]", top_path
    assert_select "a[href=?]", root_path
  end
end
