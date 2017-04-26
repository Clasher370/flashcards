require 'rails_helper'

RSpec.feature "CheckTranslation", type: :feature do
  let(:user) { create(:user) }
  let(:card) { create(:card, user_id: user.id) }

  context 'on index' do
    before { login(user.email, 'secret') }

    context 'nothing to check' do
      before { visit root_path }

      it { expect(page).to have_content 'Нет карточек на проверку'}
    end

    context 'ready to check' do
      before do
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
end
