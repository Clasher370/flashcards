require 'rails_helper'

RSpec.feature 'CheckTranslation', type: :feature do
  let(:card) { create(:card) }

  describe 'root page' do
    before { login(card.user.email, 'secret') }

    it { expect(page).to have_content 'Первый в мире' }
    it { expect(page).to have_content 'Переведите слово' }
    it { expect(page).to have_content 'дом' }

    context 'enter answer and click button' do
      before do
        fill_in :user_text, with: 'home'
        click_button
      end

      it { expect(page).to have_content 'Вы ответили правильно.' }
      it { expect(page).not_to have_content 'дом' }
    end

    context 'if answer is wrong' do
      before do
        fill_in :user_text, with: 'emoh'
        click_button
      end

      it { expect(page).to have_content 'Ваш ответ emoh неправильный. Правильный ответ дом - home.' }
    end
  end
end
