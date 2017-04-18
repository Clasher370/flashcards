require 'rails_helper'

RSpec.feature "Authenrication", type: :feature do
  it 'signin' do
    visit root_path
    first(:link, 'Зарегистрироваться').click
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'secret'
    fill_in 'Password confirmation', with: 'secret'
    click_button 'Зарегистрироваться'
    expect(page).to have_content 'Вы зарегистрировались'
  end

  context 'login and logout' do
    before do
      create(:user)
      login
    end

    it { expect(page).to have_content 'Успешный вход' }

    it 'logout' do
      click_link 'Выйти'
      expect(page).to have_content 'Вы вышли!'
    end
  end
end
