require 'rails_helper'

RSpec.describe 'Task', type: :feature do
    before(:each) do
        @user = create(:user) 
        @category = create(:category, user: @user)
        @checked_task = create(:task, :checked, category: @category)
        @unchecked_task = create(:task, :unchecked, category: @category)
        @checked_today = create(:task, :today, :checked, category: @category)
        @unchecked_today = create(:task, :today, :unchecked, category: @category)
        capybara_login(@user)
        @task = @unchecked_task
    end

    describe 'Create' do
      let!(:new_task) {
        Task.new(
          category: @category,
          title: "Final Project",
          description: 'This is a sample task.',
          due_date: Date.current,
          is_checked: false
        )
      }

      it 'shows the new task page' do
        visit new_category_task_path(category_id: @category.id)
        expect(page).to have_content('New Task')
      end

      it 'should display a notice when title is blank' do
        visit new_category_task_path(category_id: @category.id)
        fill_in('Description', :with => new_task.description)
        fill_in('Due Date', :with => new_task.due_date)
        click_on('Submit')
        
        expect(page).to have_content("Title can't be blank")
      end

      it 'should display a notice when description is blank' do
        visit new_category_task_path(category_id: @category.id)
        fill_in('Title', :with => new_task.title)
        fill_in('Due Date', :with => new_task.due_date)
        click_on('Submit')
        
        expect(page).to have_content("Description can't be blank")
      end

      it 'should display a notice when due date is blank' do
        visit new_category_task_path(category_id: @category.id)
        fill_in('Title', :with => new_task.title)
        fill_in('Description', :with => new_task.description)
        click_on('Submit')
        
        expect(page).to have_content("Due date can't be blank")
      end

      it 'should redirect to category on successful creation' do
        visit new_category_task_path(category_id: @category.id)
        fill_in('Title', :with => new_task.title)
        fill_in('Description', :with => new_task.description)
        fill_in('Due Date', :with => new_task.due_date)
        click_on('Submit')
        
        expect(page).to have_current_path(category_path(@category))
        expect(page).to have_content(new_task.title)
      end
    end

    describe 'Update' do
        let!(:updated_task) {
          Task.new(
            category: @category,
            title: "Updated Category",
            description: 'This is a sample updated category.',
            due_date: Date.current,
            is_checked: false
          )
        }

        it 'shows the edit category page' do
          visit edit_category_task_path(@task, category_id: @category.id)
          expect(page).to have_content('Edit Task')
        end
    
        it 'should display a notice when title is blank' do
          visit edit_category_task_path(@task, category_id: @category.id)
          fill_in('Title', :with => "")
          fill_in('Description', :with => updated_task.description)
          fill_in('Due Date', :with => updated_task.due_date)
          click_on('Submit')
          
          expect(page).to have_content("Title can't be blank")
        end
    
        it 'should display a notice when description is blank' do
          visit edit_category_task_path(@task, category_id: @category.id)
          fill_in('Title', :with => updated_task.title)
          fill_in('Description', :with => "")
          fill_in('Due Date', :with => updated_task.due_date)
          click_on('Submit')
          
          expect(page).to have_content("Description can't be blank")
        end
    
        it 'should display a notice when due date is blank' do
          visit edit_category_task_path(@task, category_id: @category.id)
          fill_in('Title', :with => updated_task.title)
          fill_in('Description', :with => updated_task.description)
          fill_in('Due Date', :with => "")
          click_on('Submit')
          
          expect(page).to have_content("Due date can't be blank")
        end
    
        it 'should redirect to task on successful update' do
          visit edit_category_task_path(@task, category_id: @category.id)
          fill_in('Title', :with => updated_task.title)
          fill_in('Description', :with => updated_task.description)
          fill_in('Due Date', :with => updated_task.due_date)
          click_on('Submit')
          
          expect(page).to have_current_path(category_task_path(@task, category_id: @category.id))
          expect(page).to have_content('Task Details')
          expect(page).to have_content(updated_task.title)
        end
    end

    describe 'View' do
      it 'shows the task and displays the task details' do
        visit category_task_path(@task, category_id: @category.id)
        expect(page).to have_content('Task Details')
        expect(page).to have_content(@task.title)
      end
    end

end