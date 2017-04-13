def login(email, password)
  visit root_path
  first(:link, 'Войти').click
  fill_in 'Email', with: 'email@example.com'
  fill_in 'Password', with: 'secret'
  click_button 'Войти'
end
