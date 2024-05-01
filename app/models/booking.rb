class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: ["pending", "confirmed", "declined"] }
  validate :start_date_before_end_date

  private

  def start_date_before_end_date
    if start_date >= end_date
      errors.add(:start_date, "must be before end date")
    end
  end
end
