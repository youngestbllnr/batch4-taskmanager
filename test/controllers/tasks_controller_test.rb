require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @category = categories(:one)
    @task = tasks(:one)
    log_in(@user)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    get category_url(@category)
    assert_difference('Task.count') do
      post tasks_url, params: { task: { title: @task.title, description: @task.description, due_date: @task.due_date, is_checked: @task.is_checked } }
    end

    assert_response :redirect
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { category_id: @task.category_id, description: @task.description, due_date: @task.due_date, is_checked: @task.is_checked, title: @task.title } }
    assert_response :redirect
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(Task.last)
    end

    assert_response :redirect
  end
end
