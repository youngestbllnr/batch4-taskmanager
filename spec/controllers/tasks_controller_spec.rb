require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  let!(:user) { create(:user) }
  let!(:category) { create(:category, user: user) }
  let!(:task) { create(:task, :unchecked, category: category) }

  describe "GET toggle-task" do
    it "toggles is_checked of a task" do
      sign_in user

      get :toggle_status, params: { task_id: task }
      expect(Task.find(task.id).is_checked).to eq(true)
    end

    it "redirects to today when ref param is equal to today" do
      sign_in user

      get :toggle_status, params: { task_id: task, ref: 'today' }
      expect(response).to redirect_to(today_path(anchor: "task_#{ task.id }"))
    end

    it "redirects to category when ref param is equal category" do
      sign_in user

      get :toggle_status, params: { task_id: task, ref: 'category' }
      expect(response).to redirect_to(category_path(task.category, anchor: "task_#{ task.id }"))
    end

    it "redirects to task when ref param is not present" do
      sign_in user

      get :toggle_status, params: { task_id: task }
      expect(response).to redirect_to(category_task_path(task, category_id: category.id))
    end
  end
end