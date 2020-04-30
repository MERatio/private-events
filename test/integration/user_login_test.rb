require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test 'login with valid information' do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'foobar' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', signup_path,      count: 0
    assert_select 'a[href=?]', login_path,       count: 0
    assert_select 'a[href=?]', user_path(@user), count: 1
    assert_select 'a[href=?]', logout_path,      count: 1
  end

  test 'logout' do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'foobar' } }
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'login with remember me' do
    log_in_as(@user.email, 'foobar', '1')
    assert is_logged_in?
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end

  test 'login without remember me' do
    # Log in to set cookies
    log_in_as(@user.email, 'foobar', '1')
    assert is_logged_in?
    assert_equal cookies[:remember_token], assigns(:user).remember_token
    # Log in again without remember me, and check if the cookie is deleted
    log_in_as(@user.email, 'foobar', '0')
    assert_empty cookies[:remember_token]
  end
end
