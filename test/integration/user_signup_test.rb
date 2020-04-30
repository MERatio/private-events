require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      assert_select 'form[action="/signup"]'
      post signup_path, params: { user: { name: '',
                                          username: '',
                                          email: 'user@invalid',
                                          password:              'foo',
                                          password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.form-group>div.field_with_errors'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  'Example User',
                                          username: 'example132',
                                          email: 'user@example.com',
                                          password:              'foobar',
                                          password_confirmation: 'foobar' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
