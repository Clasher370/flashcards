require 'rails_helper'

describe CheckTranslation do
  describe '#call' do
    let(:card) { create(:card) }
    let(:params) { { id: card.id, user_text: 'home', session_try: '' } }
    let(:check) { @check_card = CheckTranslation.call(params) }

    context 'answer is' do
      context 'correct' do
        before { check }

        it { expect(@check_card.notice).to include "Вы ответили правильно." }
        it { expect(@check_card.session_try).to be_nil }
        it { expect(@check_card.card).to be_nil }

        context 'card attribute change' do
          before { card.reload }

          it { expect_review_date_eq(card, 12.hour.since) }
          it { expect(card.review_stage.to_i).to eq 2 }
        end
      end

      context 'incorrect' do
        before do
          params[:user_text] = 'wrong translation'
          check
        end

        it { expect(@check_card.notice).to include 'Вы ответили неправильно. Осталось 2 попытки' }
        it { expect(@check_card.session_try).to eq 1 }
        it { expect(@check_card.card).to eq card.id }
      end
    end
  end
end
