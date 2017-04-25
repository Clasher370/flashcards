require 'rails_helper'
RSpec.describe Card, type: :model do
  context 'validates' do
    let(:card) { build(:card) }

    it { expect(card).to be_valid }

    it 'without original text' do
      card.original_text = ''
      expect(card).to_not be_valid
    end

    it 'without translated text' do
      card.translated_text = ''
      expect(card).to_not be_valid
    end

    it 'without deck' do
      card.deck_id = ''
      expect(card).to_not be_valid
    end

    it 'with same text' do
      card.translated_text = 'HoMe'
      card.valid?
      expect(card.errors[:original_text]).to include('Original and translated text should be differ')
    end
  end

  it 'is set correct date' do
    card = create(:card)
    expect(card.review_date).to eq Date.today + 3.days
  end
end
