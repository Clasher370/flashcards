require 'rails_helper'

RSpec.feature "Decks", type: :feature do
  context 'create deck' do
    let(:user) { create(:user) }
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

  context 'set current deck' do
    let(:user) { create(:user_with_decks) }

    before { login(user.email, 'secret') }

    context 'index' do
      before { visit decks_path }

      it { expect(page).to(have_button 'Вкл', count: 5) }

      context 'set' do
        before { first(:button, 'Вкл').click }

        it { expect(page).to have_content "Текущая колода #{ user.decks.first.name }" }
        it { expect(page).to have_button 'Выкл' }

        context 'unset' do
          before { click_button 'Выкл' }

          it { expect(page).to have_content 'Нет текущих колод' }
        end

        context 'set another' do
          before { first(:button, 'Вкл').click }
          it { expect(page).to have_content "Текущая колода #{user.decks.second.name}" }
          it { expect(page).to have_button('Вкл', count: 4) }
        end

        context 'show current deck cards only' do
          before do
            user.decks.each do |d|
              d.cards.create(original_text: "original #{d.id}", translated_text: "translated #{d.id}")
              d.cards.first.update(review_date: Date.yesterday)
            end
            visit root_path
          end

          it { expect(page).to have_content "translated #{user.decks.first.id}" }
        end
      end
    end
  end
end
