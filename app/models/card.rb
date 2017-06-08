class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
  validate :text_should_be_differ

  before_create :set_date, :set_stage

  belongs_to :deck
  belongs_to :user

  mount_uploader :image, ImageUploader

  scope :with_ready_date, (-> { where('review_date <= ?', Time.now) })
  scope :random, (-> { order('RANDOM()') })

  private

  def set_date
    self.review_date = Time.now
  end

  def set_stage
    self.review_stage = 1
  end

  def text_should_be_differ
    return unless original_text.downcase == translated_text.downcase
    errors.add(:original_text, 'Original and translated text should be differ')
  end
end
