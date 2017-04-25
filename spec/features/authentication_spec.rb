require 'rails_helper'

RSpec.feature "Authenrication", type: :feature do
  context 'need login to visit root' do
    before { visit root_path }

    it { expect(page).to have_content 'Необходимо войти' }
  end

  context 'signin' do
    before do
      visit signup_path
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: 'secret'
      fill_in 'Password confirmation', with: 'secret'
      click_button 'Зарегистрироваться'
    end

    it { expect(page).to have_content 'Вы зарегистрировались' }
    it { expect(page).to have_content 'email@example.com'}

    context 'user can' do
      before { click_link 'Выйти'}

      it 'logout' do
        expect(page).to have_content 'Вы вышли!'
      end

      context 'login' do
        before do
          fill_in 'Email', with: 'email@example.com'
          fill_in 'Password', with: 'secret'
          click_button
        end

        it { expect(page).to have_content 'Успешный вход' }
      end
    end
  end
end
