class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: ["pending", "confirmed", "declined"] }
end
