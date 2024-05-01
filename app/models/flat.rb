class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, :description, :price_per_night, presence: true
end
