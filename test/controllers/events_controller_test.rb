require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect new when not logged in' do
    get new_event_path
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Event.count' do
      title = 'Lorem rabbit'
      description = 'Lorem ipsum'
      location = 'Mars'
      start_date = Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now)
      end_date = Faker::Date.between(from: 30.days.from_now, to: 60.days.from_now)
      post events_path, params: { 
        event: { title: title,
                 description: description,
                 location: location,
                 start_date: start_date,
                 end_date: end_date } }
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end
