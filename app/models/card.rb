class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_should_be_differ

  before_validation :set_date

  private

  def set_date
    self.review_date = Date.today + 3.days
  end

  def text_should_be_differ
    return unless original_text.downcase == translated_text.downcase
    errors.add(:original_text, "Original and translated text should be differ")
  end
end
