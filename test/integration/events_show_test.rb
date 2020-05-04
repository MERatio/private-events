require 'test_helper'

class EventsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @event = events(:birthday)
  end

  test 'events show of upcoming event' do
    log_in_as(@user.email, 'foobar', '0')
    get event_path(@event)
    assert_match @event.title, response.body
    assert_select 'a[href=?]', "/events/#{@event.id}/invite", count: 1
    assert_match @event.creator.name, response.body
    assert_match @event.description, response.body
    assert_match @event.location, response.body
    assert_match @event.start_date.to_s(:rfc822), response.body
    assert_match @event.end_date.to_s(:rfc822), response.body
  end
end
