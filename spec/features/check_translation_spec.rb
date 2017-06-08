require 'rails_helper'

RSpec.feature "CheckTranslation", type: :feature do
  let(:card) { create(:card) }

  describe 'root page' do
    before { login(card.user.email, 'secret') }

    it { expect(page).to have_content 'Первый в мире' }
    it { expect(page).to have_content 'Переведите слово' }
    it { expect(page).to have_content 'дом' }

    context 'enter answer and click button' do
      before do
        fill_in :user_text, with: 'home'
        click_button 'Button'
      end

      it { expect(page).to have_content 'Вы ответили правильно.' }
      it { expect(page).not_to have_content 'дом' }
    end

    context 'enter wrong or empty answer' do
      it 'first time, left 2 try' do
        click_button 'Button'
        expect(page).to have_content 'Вы ответили неправильно. Осталось 2 попытки.'
      end

      it 'second time, left 1 try' do
        2.times { click_button 'Button' }
        expect(page).to have_content 'Вы ответили неправильно. Осталось 1 попытки.'
      end

      it 'third time, another card for check' do
        3.times { click_button 'Button' }
        expect(page).not_to have_content 'Вы ответили неправильно. Осталось'
        expect(page).not_to have_content 'дом'
      end
    end
  end
end

