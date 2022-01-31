require 'test_helper'


class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params:{ session: {email: @user.email, password: "invalid"} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get statictics_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params:{ session: {email: @user.email, password: 'password'}}
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'home/home'
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", statictics_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", statictics_path, count: 0
  end

end
