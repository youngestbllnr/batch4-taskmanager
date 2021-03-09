require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @category = categories(:one)
    @task = tasks(:one)
    @other_task = tasks(:two)
    log_in(@user)
  end

  test "should get new" do
    get new_category_task_url(category_id: @category.id)
    assert_response :success
  end

  test "should create task" do
    get category_url(@category)
    assert_difference('Task.count') do
      post category_tasks_url(category_id: @category.id), params: { task: { title: @task.title, description: @task.description, due_date: @task.due_date, is_checked: @task.is_checked } }
    end

    assert_response :redirect
  end

  test "should show task" do
    get category_task_url(@task, category_id: @category.id)
    assert_response :success
  end

  test "should not show task when it does not belong to user" do
    get category_task_url(@other_task, category_id: @category.id)
    assert_response :redirect
  end

  test "should get edit" do
    get edit_category_task_url(@task, category_id: @category.id)
    assert_response :success
  end

  test "should update task" do
    patch category_task_url(@task, category_id: @category.id), params: { task: { category_id: @task.category_id, description: @task.description, due_date: @task.due_date, is_checked: @task.is_checked, title: @task.title } }
    assert_response :redirect
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete category_task_url(@task, category_id: @category.id)
    end

    assert_response :redirect
  end
end
