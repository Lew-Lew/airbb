class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: ["pending", "confirmed", "declined"] }
  validate :start_date_before_end_date
  validate :no_overlap

  private

  def start_date_before_end_date
    if start_date >= end_date
      errors.add(:start_date, "must be before end date")
    end
  end

  def no_overlap
    if (Booking.where(flat_id: flat_id).where("(? <= end_date) and (? >= start_date)", self.start_date, self.end_date).where(status: "confirmed").any?)
      errors.add(:base, 'There is an overlapping booking')
    end
  end
end
