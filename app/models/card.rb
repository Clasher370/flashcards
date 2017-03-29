class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true, uniqueness: :case_sensitive
  validates :original_text, uniqueness: { scope: :translated_text }
  validates :review_date, presence: true
end

