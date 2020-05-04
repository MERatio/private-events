class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many   :invitations
  has_many   :attendees, through: :invitations, source: :attendee

  scope      :past,     -> { where('start_date < ?', Date.today) }
  scope      :upcoming, -> { where('start_date >= ?', Date.today) }

  validates  :creator_id, presence: true
  validates  :title, presence: true, length: { maximum: 255 }
  validates  :description, presence: true, length: { maximum: 2000 }
  validates  :location, presence: true, length: { maximum: 255 }
  validates  :start_date, presence: true
  validates  :end_date, presence: true
  validate   :dates_cannot_be_in_the_past,
             :start_date_cannot_be_higher_than_end_date

  def upcoming?
    self.start_date >= Date.today
  end

  private

    def dates_cannot_be_in_the_past
      if (start_date.present? && start_date < Date.today)
        errors.add(:start_date, "can't be in the past")
      end
      if (end_date.present? && end_date < Date.today)
        errors.add(:end_date, "can't be in the past")
      end
    end

    def start_date_cannot_be_higher_than_end_date
      if (start_date.present? && end_date.present?)
        if (start_date > end_date)
          errors.add(:start_date, "can't be higher than end date")
        end
      end
    end
end
