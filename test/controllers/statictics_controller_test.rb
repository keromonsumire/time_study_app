require 'test_helper'

class StaticticsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get top_path
    assert_response :success
    assert_select "title", "統計 | Time Keeper"
  end

end
