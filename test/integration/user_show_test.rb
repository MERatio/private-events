require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1.d-inline', @user.name
    assert_match @user.events.count.to_s, response.body
    @user.events.paginate(page: 1).each do |event|
      assert_match event.title, response.body
      assert_match event.description, response.body
      assert_match event.location, response.body
      assert_match event.start_date.to_s(:rfc822), response.body
      assert_match event.end_date.to_s(:rfc822), response.body
      assert_select 'a[href=?]', event_path(event), count: 1
    end
    assert_select 'ul.pagination', count: 1
  end
end
