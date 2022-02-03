require 'test_helper'

class StaticticsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "should get top" do
    get login_path
    post login_path, params:{ session: {email: @user.email, password: 'password'}}
    get statictics_path
    assert_response :success
    assert_select "title", "統計 | Time Keeper"
  end
end
