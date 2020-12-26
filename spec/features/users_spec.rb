require 'rails_helper'

RSpec.feature "Users Auth", type: :feature do
  it 'visit registration page' do
    visit(new_user_registration_path)
    expect(page).to have_current_path(new_user_registration_path) 
  end

  it 'visit login page' do
    visit(new_user_session_path)
    expect(page).to have_current_path(new_user_session_path) 
  end
  
  it 'registrate a new user' do
    visit(new_user_registration_path)
    fill_in 'Name',	with: Faker::Name.name 
    fill_in 'Email',	with: Faker::Internet.email 
    fill_in 'Password',	with: '123123'
    fill_in 'Password confirmation',	with: '123123'
    click_button 'Criar conta'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
  
  it 'login as user' do
    user = create(:user)
    visit(new_user_session_path)
    fill_in 'Email', with: user.email
    fill_in 'Password',	with: '123123'
    click_button 'Entrar'
    expect(page).to have_content 'Signed in successfully.'
  end
end
