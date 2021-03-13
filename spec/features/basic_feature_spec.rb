require 'rails_helper'

RSpec.describe 'Basic Feature', type: :feature do

    describe 'index page' do
      it 'shows the right content' do
        visit root_path
        expect(page).to have_content('Quest')
      end
    end

end