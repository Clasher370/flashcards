class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true

  scope :by_create_date, (-> { order(:created_at) })
end
