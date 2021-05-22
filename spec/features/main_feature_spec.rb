require 'rails_helper'

RSpec.describe 'Main', type: :feature do
  describe 'Dashboard' do
    it 'renders "Hello" as a hello message for English users' do
      @user = create(:user)
      capybara_login(@user) 

      visit dashboard_path
      expect(page).to have_content('Hello')
    end

    it 'renders "Kamusta" as a hello message for Filipino users' do
      @user = create(:user, :filipino)
      capybara_login(@user)
      
      visit dashboard_path
      expect(page).to have_content('Kamusta')
    end

    it 'displays a card for each of the user\'s categories and one for today\'s tasks' do
      @user = create(:user) 
      @category = create(:category, user: @user)
      capybara_login(@user)

      visit dashboard_path
      expect(page).to have_content(@category.title)
      expect(page).to have_content('Today')
    end
  end

  describe 'Today' do

    it 'shows the user\'s tasks for today' do
      @user = create(:user) 
      @category = create(:category, user: @user)
      @checked_task = create(:task, :checked, category: @category)
      @unchecked_task = create(:task, :unchecked, category: @category)
      @checked_today = create(:task, :today, :checked, category: @category)
      @unchecked_today = create(:task, :today, :unchecked, category: @category)
      capybara_login(@user)

      visit today_path
      expect(page).to have_content('Today')
      expect(page).to have_content(@checked_today.title)
      expect(page).to have_content(@unchecked_today.title)
    end
  end
end
