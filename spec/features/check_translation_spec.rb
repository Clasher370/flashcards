require 'rails_helper'

RSpec.feature "CheckTranslation", type: :feature do
  let(:card) { create(:card) }

  context 'card on index' do
    before { login(card.user.email, 'secret') }

    context 'is ready to check' do
      it { expect(page).to have_content 'Первый в мире' }
      it { expect(page).to have_content 'Переведите слово' }
      it { expect(page).to have_content 'дом' }

      context 'when right answer' do
        before do
          fill_in :user_text, with: 'home'
          click_button 'Button'
        end

        it { expect(page).to have_content 'Вы ответили правильно.' }
      end

      context 'when wrong answer' do
        before do
          fill_in :user_text, with: 'NOhome'
          click_button 'Button'
        end

        it { expect(page).to have_content 'Вы ответили неправильно.' }
      end
    end
  end
end
