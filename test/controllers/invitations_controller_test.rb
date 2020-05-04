require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect new when not logged in' do
    get '/events/1/invite'
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Invitation.count' do
      post '/events/21/invite', params: { invitation: { user_id: '1', event_id: '1' }  }
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
end
