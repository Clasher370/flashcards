require 'rails_helper'

RSpec.feature 'CreateCard', type: :feature do
  describe 'new card' do
    before do
      @user = create(:user)
      login
      visit new_card_path
      fill_in :card_original_text, with: 'white'
      fill_in :card_translated_text, with: 'белый'
      attach_file :card_image, 'app/assets/images/test_image.jpg'
      click_button 'Create Card'
    end

    it { expect(page).to have_content 'Новая карта создана' }

    context 'card with image on index' do
      before do
        @card = @user.cards.first
        @card.update(review_date: Date.yesterday)
      end

      it 'is have image' do
        visit root_path
        expect(page).to have_css('img.card_image')
      end
    end
  end
end
