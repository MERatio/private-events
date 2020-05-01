require 'test_helper'

class EventInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'event interface' do
    log_in_as(@user.email, 'foobar', '0')
    get new_event_path
    assert_select 'input[type=text]', count: 3
    assert_select 'input[type=date]', count: 2
    # Invalid submission
    assert_no_difference 'Event.count' do
      post events_path, params: { event: { title: 'Lorem',
                                           description: '',
                                           location: '',
                                           start_date: ''  } }
    end
    assert_select 'div#error_explanation'  
    # Valid submission
    title = 'Lorem cat'
    description = 'Lorem ipsum'
    location = 'Mars'
    start_date = Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now)
    end_date = Faker::Date.between(from: 30.days.from_now, to: 60.days.from_now)
    assert_difference 'Event.count', 1 do
      post events_path, params: { 
        event: { title: title,
                 description: description,
                 location: location,
                 start_date: start_date,
                 end_date: end_date } }
    end 
    assert_redirected_to events_path
  end
end
