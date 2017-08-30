require 'rails_helper'

describe SuperMemo do
  describe 'perfect' do
    let(:card) { create(:card, review_stage: 5, easiness: 3.0) }

    before do
      SuperMemo.new(card.id, 'home', 14).algorithm
      card.reload
    end

    it { expect_time_eq(card.review_date, 12.hour.since) }
    it { expect(card.easiness).to eq 3.1 }
    it { expect(card.review_stage).to eq 6 }
  end

  describe 'good' do
    let(:card) { create(:card, review_stage: 7, easiness: 3.5) }

    before do
      SuperMemo.new(card.id, 'home', 46).algorithm
      card.reload
    end

    it { expect_time_eq(card.review_date, 21.hour.since) }
    it { expect(card.easiness).to eq 3.36 }
    it { expect(card.review_stage).to eq 8 }
  end

  describe 'bad' do
    let(:card) { create(:card, review_stage: 10, easiness: 4.5) }

    before do
      SuperMemo.new(card.id, 'emoh', 99).algorithm
      card.reload
    end

    it { expect_time_eq(card.review_date, 1.hour.since) }
    it { expect(card.easiness).to eq 4.5 }
    it { expect(card.review_stage).to eq 1 }
  end

  describe 'hard card have 1.3 easiness' do
    let(:card) { create(:card, review_stage: 5, easiness: 1.0) }

    before do
      SuperMemo.new(card.id, 'home', 99).algorithm
      card.reload
    end

    it { expect(card.easiness).to eq 1.3 }
  end
end
