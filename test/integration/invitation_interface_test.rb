require 'test_helper'

class InvitationInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'invitation interface' do
    log_in_as(@user.email, 'foobar', '0')
    get '/events/1/invite'
    assert_select 'input[type=text]', count: 1
    # Invalid submission
    assert_no_difference 'User.find(2).attended_events.count' do
      post '/events/1/invite', params: { invitation: { attendee_id: 200, event_id: 1 } }
    end
    assert_select 'div#error_explanation'  
    assert_no_difference 'User.find(2).attended_events.count' do
      post '/events/1/invite', params: { invitation: { attendee_id: 'John Doe', event_id: 1 } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    assert_difference 'User.find(2).attended_events.count', 1 do
      post '/events/1/invite', params: { invitation: { attendee_id: '2', event_id: '1' } }
    end
  end
end
