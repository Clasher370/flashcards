def login(email, password)
  visit :login
  fill_in :user_session_email, with: email
  fill_in :user_session_password, with: password
  click_button
end
