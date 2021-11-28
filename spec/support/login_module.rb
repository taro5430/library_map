module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  def admin_login(user)
    visit new_user_session_path
    fill_in 'Eメール', with: admin_user.email
    fill_in 'パスワード', with: admin_user.password
    click_button 'ログイン'
  end
end
