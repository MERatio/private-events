require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1.card-header', @user.name
  end
end
