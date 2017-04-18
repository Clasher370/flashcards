def login
  visit root_path
  first(:link, 'Войти').click
  fill_in :user_session_email, with: 'email@example.com'
  fill_in :user_session_password, with: 'secret'
  click_button 'Войти'
end
