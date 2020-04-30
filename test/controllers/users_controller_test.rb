require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select 'title', full_title('Sign up')
    assert_select 'form[action="/signup"]'
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
    assert_select 'title', full_title(@user.name)
    assert_match @user.name, response.body
  end
end
