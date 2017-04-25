require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  describe 'new' do
    before do
      @user = create(:user)
      @deck = @user.decks.create(name: 'Colors')
      login(@user.email, 'secret')
      visit new_card_path
      fill_in 'Original text', with: 'white'
      fill_in 'Translated text', with: 'белый'
      attach_file :card_image, 'app/assets/images/test_image.jpg'
      click_button
    end

    it { expect(page).to have_content 'Новая карта создана' }
    it 'belongs to desk' do
      visit cards_path
      expect(page).to have_content 'Colors'
    end

    context 'card with image on index' do
      before do
        @card = @user.cards.first
        @card.update(review_date: Date.yesterday)
      end

      it 'random card have image' do
        visit root_path
        expect(page).to have_css('img.card_image', count: 1)
      end
    end

    context 'edit and delete card' do
      before do
        visit cards_path
      end

      context 'edit' do
        before do
          click_link 'Edit'
          fill_in 'Original text', with: 'Black'
          click_button
        end

        it { expect(page).to have_content 'Карта изменена' }
        it { expect(page).to have_content 'Black' }
      end

      context 'delete' do
        before do
          click_link 'Delete'
        end

        it { expect(page).to have_content 'Карта удалена'}
        it { expect(Card.count).to eq 0 }
      end
    end
  end
end
