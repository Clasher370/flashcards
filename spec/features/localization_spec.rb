require 'rails_helper'

RSpec.feature 'Localization', type: :feature do
  describe 'unregistered user' do
    context 'ru locale' do
      before { visit root_path }

      it { expect(page).to have_content 'Флэшкарточкер' }
    end
    context 'en locale' do
      before do
        visit root_path
        click_link 'en'
      end

      it { expect(page).to have_content 'Flashcard' }
    end
  end

  describe 'registered user' do
    context 'ru locale' do
      let(:user) { create(:user, locale: 'ru') }

      before do
        login(user.email, 'secret')
      end
      it { expect(user.locale).to eq 'ru' }
      it { expect(page).to have_content 'Флэшкарточкер' }
    end
    context 'en locale' do
      let(:user) { create(:user, locale: 'en') }

      before { login(user.email, 'secret') }

      it { expect(page).to have_content 'Flashcard' }
    end
  end
end
