require 'rails_helper'

RSpec.feature 'Decks', type: :feature do
  let(:user) { create(:user) }

  context 'create' do
    before do
      login(user.email, 'secret')
      visit root_path
    end

    it { expect(page).to have_content 'Нет карточек на проверку' }

    context 'use form' do
      before { click_link 'Добавить колоду' }

      context 'without name' do
        before { click_button }

        it { expect(page).to have_content 'Заполни это поле' }
      end

      context 'with name' do
        before do
          fill_in 'Name', with: 'NewDeck'
          click_button
        end

        it { expect(page).to have_content 'Новая колода создана' }
        it { expect(page).to have_content 'NewDeck' }
      end
    end
  end
end
