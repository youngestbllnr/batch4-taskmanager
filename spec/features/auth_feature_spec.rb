require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do

    describe 'Log In' do
      let!(:user) { create(:user) }

      it 'shows the login page' do
        visit new_user_session_path
        expect(page).to have_content('Log in')
      end

      it 'should display a notice when email is invalid' do
        visit new_user_session_path
        fill_in('Email', :with => "WRONG EMAIL")
        fill_in('Password', :with => user.password)
        click_on('Log In')
        
        expect(page).to have_content('Invalid email or password.')
      end

      it 'should display a notice when password is invalid' do
        visit new_user_session_path
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => "WRONG PASSWORD")
        click_on('Log In')
        
        expect(page).to have_content('Invalid email or password.')
      end

      it 'should redirect the user to dashboard on successful login' do
        visit new_user_session_path
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        click_on('Log In')
        
        expect(page).to have_current_path(dashboard_path)
      end
    end

    describe 'Sign Up' do
      let!(:user) { 
        User.new(
          email: "johndoe@gmail.com",
          password: "password",
          firstname: "John",
          lastname: "Doe"
        )
      }

      it 'shows the signup page' do
        visit new_user_registration_path
        expect(page).to have_content('Sign up')
      end

      it 'should display a notice when firstname is blank' do
        visit new_user_registration_path
        fill_in('Last Name', :with => user.lastname)
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        fill_in('Confirm Password', :with => user.password)
        click_on('Sign Up')
        
        expect(page).to have_content("Firstname can't be blank")
      end

      it 'should display a notice when lastname is blank' do
        visit new_user_registration_path
        fill_in('First Name', :with => user.firstname)
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        fill_in('Confirm Password', :with => user.password)
        click_on('Sign Up')
        
        expect(page).to have_content("Lastname can't be blank")
      end

      it 'should display a notice when email is blank' do
        visit new_user_registration_path
        fill_in('First Name', :with => user.firstname)
        fill_in('Last Name', :with => user.lastname)
        fill_in('Password', :with => user.password)
        fill_in('Confirm Password', :with => user.password)
        click_on('Sign Up')
        
        expect(page).to have_content("Email can't be blank")
      end

      it 'should display a notice when password is blank' do
        visit new_user_registration_path
        fill_in('First Name', :with => user.firstname)
        fill_in('Last Name', :with => user.lastname)
        fill_in('Email', :with => user.email)
        fill_in('Confirm Password', :with => user.password)
        click_on('Sign Up')
        
        expect(page).to have_content("Password can't be blank")
      end

      it 'should display a notice when password confirmation does not match password' do
        visit new_user_registration_path
        fill_in('First Name', :with => user.firstname)
        fill_in('Last Name', :with => user.lastname)
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        fill_in('Confirm Password', :with => "")
        click_on('Sign Up')
        
        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it 'should redirect the user to dashboard on successful signup' do
        visit new_user_registration_path
        fill_in('First Name', :with => user.firstname)
        fill_in('Last Name', :with => user.lastname)
        fill_in('Email', :with => user.email)
        fill_in('Password', :with => user.password)
        fill_in('Confirm Password', :with => user.password)
        click_on('Sign Up')
        
        expect(page).to have_current_path(dashboard_path)
      end
    end

end