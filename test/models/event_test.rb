require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    title = 'Lorem dog'
    description = 'Lorem ipsum',
    location = 'Mars'
    start_date = Faker::Date.between(from: 2.days.from_now, to: 30.days.from_now)
    end_date = Faker::Date.between(from: 30.days.from_now, to: 60.days.from_now)
    @event = @user.events.build(title: title,
                                description: description,
                                location: location,
                                start_date: start_date,
                                end_date: end_date)
  end

  test 'should be valid' do
    assert @event.valid?
  end

  test 'owner id should be present' do
    @event.creator_id = nil
    assert_not @event.valid?
  end

  test 'title should be present' do
    @event.title = nil
    assert_not @event.valid?
  end

  test 'title should be at most 255 characters' do
    @event.title = 'a' * 256
    assert_not @event.valid?
  end

  test 'description should be present' do
    @event.description = nil
    assert_not @event.valid?
  end

  test 'description should be at most 2000 characters' do
    @event.description = 'a' * 2001
    assert_not @event.valid?
  end

  test 'location should be present' do
    @event.location = nil
    assert_not @event.valid?
  end

  test 'location should be at most 255 characters' do
    @event.location = 'a' * 256
    assert_not @event.valid?
  end

  test 'start_date should be present' do
    @event.start_date = nil
    assert_not @event.valid?
  end

  test 'end_date should be present' do
    @event.end_date = nil
    assert_not @event.valid?
  end

  test 'dates cannot be in the past' do
    @event.start_date = 10.days.ago
    @event.end_date = 2.days.ago
    assert_not @event.valid?
  end

  test 'start_date cannot be higher than end_date' do
    @event.start_date = 14.days.from_now
    @event.end_date = 7.days.from_now
    assert_not @event.valid?
  end
end
