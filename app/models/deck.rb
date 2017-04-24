class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards

  validates :name, presence: true

  scope :to_create_date, (-> { order(:created_at) })
  scope :to_current, (-> { where(current: true) })
end
