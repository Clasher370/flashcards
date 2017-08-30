require 'rails_helper'

describe SuperMemo do
  let(:card) { create(:card) }
  let(:memo) { SuperMemo.new(card.id, nil, nil) }

  describe '#update_card' do
    context 'if incorrect answer' do
      before { memo.update_card(card, 5) }

      it { expect_time_eq(card.review_date, 1.hour.since) }
      it { expect(card.easiness).to eq 2.6 }
      it { expect(card.review_stage).to eq 2 }
    end

    context 'if correct answer' do
      before { memo.update_card(card, 2) }

      it { expect_time_eq(card.review_date, 1.hour.since) }
      it { expect(card.easiness).to eq 2.5 }
      it { expect(card.review_stage).to eq 1 }
    end
  end

  describe '#compare' do
    it { expect(memo.compare('cat', 'cat')).to eq 0 }
    it { expect(memo.compare('cat', 'ca')).to eq 1 }
    it { expect(memo.compare('cat', 'c')).to eq 2 }
    it { expect(memo.compare('cat', '')).to eq 3 }
  end

  describe '#quality_of_repetition' do
    it { expect(memo.quality_of_repetition(3, 1)).to eq(0) }
    it { expect(memo.quality_of_repetition(0, 15)).to eq(5) }
    it { expect(memo.quality_of_repetition(0, 45)).to eq(4) }
    it { expect(memo.quality_of_repetition(0, 46)).to eq(3) }
    it { expect(memo.quality_of_repetition(1, 1)).to eq(2) }
    it { expect(memo.quality_of_repetition(2, 1)).to eq(1) }
  end

  describe '#update_easiness' do
    it { expect(memo.update_easiness(card, 5)).to eq 2.6 }
    it { expect(memo.update_easiness(card, 4)).to eq 2.5 }
    it { expect(memo.update_easiness(card, 3)).to eq 2.36 }
  end

  describe '#update_interval' do # default easiness value 2.5
    it { expect_time_eq(memo.update_interval(card, 1), 1.hour.since) }
    it { expect_time_eq(memo.update_interval(card, 2), 6.hour.since) }
    it { expect_time_eq(memo.update_interval(card, 3), 5.hour.since) }
    it { expect_time_eq(memo.update_interval(card, 4), 8.hour.since) }
  end
end
