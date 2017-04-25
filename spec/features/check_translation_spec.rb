require 'rails_helper'

RSpec.feature "CheckTranslation", type: :feature do
  let(:card) { create(:card) }

  context 'card on index' do
    before do
      login(card.deck.user.email, 'secret')
      card.update(review_date: Date.yesterday)
      visit root_path
    end

    it { expect(page).to have_content 'Первый в мире' }
    it { expect(page).to have_content 'Переведите слово' }
    it { expect(page).to have_content 'дом' }

    context 'right answer' do
      before do
        fill_in :user_text, with: 'home'
        click_button 'Button'
      end

      it { expect(page).to have_content 'Вы ответили правильно.' }
      it { expect(page).not_to have_content 'дом' }
    end

    context 'wrong answer' do
      before do
        fill_in :user_text, with: 'NOhome'
        click_button 'Button'
      end

      it { expect(page).to have_content 'Вы ответили неправильно.' }
    end
  end
end
