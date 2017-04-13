require 'rails_helper'

RSpec.feature "Cards", type: :feature do
  describe 'index' do
    before(:each) do
      user = create(:user)
      login(user.email, user.password)
      create(:card, user_id: user.id)
      create(:card, original_text: 'Earth', translated_text: 'Земля', user_id: user.id)
      visit root_path
      click_link 'Мои карточки'
      click_link 'Все карточки'
    end

    it { expect(page).to have_content 'Original text' }
    it { expect(page).to have_content 'home' }
    it { expect(page).to have_content 'Земля' }
  end
end
