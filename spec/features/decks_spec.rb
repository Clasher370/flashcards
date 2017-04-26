require 'rails_helper'

RSpec.feature "Decks", type: :feature do
  let(:user) { create(:user) }

  context 'create deck' do
    before { login(user.email, 'secret') }
    before { visit root_path }

    it { expect(page).to have_content 'Нет карточек на проверку' }

    context 'not create card without deck' do
      before { first(:link, 'Добавить карточку').click }

      it { expect(page).to have_content 'Необходимо создать колоду' }
    end

    context 'use form' do
      before { click_link 'Добавить колоду' }

      context 'try to create' do
        it 'without name' do
          click_button
          expect(page).to have_content "can't be blank"
        end
      end

      context 'creating' do
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
