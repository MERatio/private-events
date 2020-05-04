require 'test_helper'

class EventsIndexTest < ActionDispatch::IntegrationTest
  test 'display index when logged in' do
    log_in_as('johndoe@example.com', 'foobar', '0')
    get events_path
    assert_template 'events/index'
    first_page_of_events = Event.paginate(page: 1)
    first_page_of_events.each do |event| 
      assert_match event.title, response.body
      assert_match event.description, response.body
      assert_match event.location, response.body
      assert_match event.start_date.to_s(:rfc822), response.body
      assert_match event.end_date.to_s(:rfc822), response.body
      assert_select 'a[href=?]', event_path(event), count: 1
    end
    assert_select 'ul.pagination', count: 1
  end

  test 'cannot display index when not logged in' do
    get events_path
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end
