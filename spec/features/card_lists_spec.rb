require 'rails_helper'

RSpec.feature "CardLists", type: :feature do
  context 'user can see list of cards' do
    before(:each) do
      create(:card)
      create(:card, original_text: 'Earth', translated_text: 'Земля')
      visit '/'
      click_link 'Все карточки'
    end

    it { expect(page).to have_content 'Original text' }
    it { expect(page).to have_content 'home' }
    it { expect(page).to have_content 'Земля' }
  end
end
