require 'rails_helper'

RSpec.describe 'Category', type: :feature do
    before(:each) do
        @user = create(:user) 
        @category = create(:category, user: @user)
        @checked_task = create(:task, :checked, category: @category)
        @unchecked_task = create(:task, :unchecked, category: @category)
        @checked_today = create(:task, :today, :checked, category: @category)
        @unchecked_today = create(:task, :today, :unchecked, category: @category)
        capybara_login(@user)
    end

    describe 'Create' do
      let!(:new_category) {
        Category.new(
          user: @user,
          title: "Projects",
          icon: '🚀',
          description: 'This is a sample category.'
        )
      }

      it 'shows the new category page' do
        visit new_category_path
        expect(page).to have_content('New Category')
      end

      it 'should display a notice when title is blank' do
        visit new_category_path
        fill_in('Select an Icon', :with => new_category.icon)
        fill_in('Description', :with => new_category.description)
        click_on('Submit')
        
        expect(page).to have_content("Title can't be blank")
      end

      it 'should display a notice when icon is blank' do
        visit new_category_path
        fill_in('Title', :with => new_category.title)
        fill_in('Description', :with => new_category.description)
        click_on('Submit')
        
        expect(page).to have_content("Icon can't be blank")
      end

      it 'should display a notice when description is blank' do
        visit new_category_path
        fill_in('Title', :with => new_category.title)
        fill_in('Select an Icon', :with => new_category.icon)
        click_on('Submit')
        
        expect(page).to have_content("Description can't be blank")
      end

      it 'should redirect to category on successful creation' do
        visit new_category_path
        fill_in('Title', :with => new_category.title)
        fill_in('Select an Icon', :with => new_category.icon)
        fill_in('Description', :with => new_category.description)
        click_on('Submit')
        
        expect(page).to have_current_path(category_path(Category.last))
        expect(page).to have_content(new_category.title)
      end
    end

    describe 'Update' do
        let!(:updated_category) {
          Category.new(
            user: @user,
            title: "Updated Category",
            icon: '✅',
            description: 'This is a sample updated category.'
          )
        }

        it 'shows the edit category page' do
          visit edit_category_path(@category)
          expect(page).to have_content('Edit Category')
        end
    
        it 'should display a notice when title is blank' do
          visit edit_category_path(@category)
          fill_in('Title', :with => "")
          fill_in('Select an Icon', :with => updated_category.icon)
          fill_in('Description', :with => updated_category.description)
          click_on('Submit')
          
          expect(page).to have_content("Title can't be blank")
        end
    
        it 'should display a notice when icon is blank' do
          visit edit_category_path(@category)
          fill_in('Title', :with => updated_category.title)
          fill_in('Select an Icon', :with => "")
          fill_in('Description', :with => updated_category.description)
          click_on('Submit')
          
          expect(page).to have_content("Icon can't be blank")
        end
    
        it 'should display a notice when description is blank' do
          visit edit_category_path(@category)
          fill_in('Title', :with => updated_category.title)
          fill_in('Select an Icon', :with => updated_category.icon)
          fill_in('Description', :with => "")
          click_on('Submit')
          
          expect(page).to have_content("Description can't be blank")
        end
    
        it 'should redirect to category on successful update' do
          visit edit_category_path(@category)
          fill_in('Title', :with => updated_category.title)
          fill_in('Select an Icon', :with => updated_category.icon)
          fill_in('Description', :with => updated_category.description)
          click_on('Submit')
          
          expect(page).to have_current_path(category_path(@category))
          expect(page).to have_content(updated_category.title)
        end
    end

    describe 'View' do
      it 'shows the category and displays the tasks within' do
        visit category_path(@category)
        expect(page).to have_content(@category.title)
        expect(page).to have_content(@checked_task.title)
        expect(page).to have_content(@unchecked_task.title)
      end
    end

end