class Flat < ApplicationRecord
  geocoded_by :address
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, :description, :address, :price_per_night, presence: true
  after_validation :geocode, if: :will_save_change_to_address?
end
