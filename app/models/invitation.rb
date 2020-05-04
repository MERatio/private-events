class Invitation < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :event

  validates  :attendee_id, presence: true
  validates  :event_id, presence: true
  validates  :attendee_id, uniqueness: { scope: :event_id, message: 'is already invited' }
end
