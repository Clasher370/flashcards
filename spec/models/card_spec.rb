require 'rails_helper'
RSpec.describe Card, type: :model do
  context 'invalid' do
    it 'without original text' do
      card = build(:card, original_text: '')
      expect(card).to_not be_valid
    end

    it 'without translated text' do
      card = build(:card, translated_text: '')
      expect(card).to_not be_valid
    end

    it 'with same text' do
      card = build(:card, translated_text: 'HoMe')
      card.valid?
      expect(card.errors[:original_text]).to include('Original and translated text should be differ')
    end
  end

  context 'valid' do
    let!(:card) { build(:card) }

    it 'is valid with original, translated text and review date' do
      expect(card).to be_valid
    end

    it 'is set correct date' do
      card.valid?
      expect(card.review_date).to eq Date.today + 3.days
    end
  end
end
