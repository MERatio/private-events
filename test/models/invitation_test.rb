require 'test_helper'

class InvitationTest < ActiveSupport::TestCase

  def setup
    @invitation = Invitation.new(attendee_id: 2, event_id: 1)
  end

  test 'should be valid' do
    assert @invitation.valid?
  end

  test 'attendee_id should be present' do
    @invitation.attendee_id = nil
    assert_not @invitation.valid?
  end

  test 'event_id should be present' do
    @invitation.event_id = nil
    assert_not @invitation.valid?
  end

  test 'record should be unique' do
    @invitation.save
    @invitation2 = Invitation.new(attendee_id: 2, event_id: 1)
    assert_not @invitation2.valid?
  end
end
