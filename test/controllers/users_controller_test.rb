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

  test "should get show when logged in" do
    log_in_as(@user.email, 'foobar', '0')
    get user_path(@user)
    assert_response :success
    assert_select 'title', full_title(@user.name)
    assert_match @user.name, response.body
  end

  test 'redirect show when not logged in' do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end
