require "test_helper"

class QuestFlowTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:one)
    @category = categories(:one)
    @task = tasks(:one)
  end

  test "can see the landing page" do
    get root_url
    assert_select "p", "Quest"
  end

  test "can see the dashboard" do
    log_in(@user)
    get dashboard_url
    assert_response :success
  end

  test "can create a category" do
    log_in(@user)
    get dashboard_url
    assert_response :success
  
    post categories_url, params: { category: { description: @category.description, icon: @category.icon, title: @category.title, user: @user } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Category was successfully created."
  end

  test "can edit a category" do
    log_in(@user)
    get category_url(@category)
    assert_response :success
  
    patch category_url(@category), params: { category: { title: "#{ @category.title } (updated)" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Category was successfully updated."
  end

  test "can delete a category" do
    log_in(@user)
    get category_url(@category)
    assert_response :success
  
    delete category_url(@category)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Category was successfully deleted."
  end

  test "can create a task" do
    log_in(@user)
    get category_url(@category)
    assert_response :success
  
    post tasks_url, params: { task: { title: @task.title, description: @task.description, due_date: @task.due_date, is_checked: @task.is_checked } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Task was successfully created."
  end

  test "can toggle a task" do
    log_in(@user)
    get task_url(@task)
    assert_response :success
  
    get toggle_task_url, params: { task_id: @task.id }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "can edit a task" do
    log_in(@user)
    get task_url(@task)
    assert_response :success
  
    patch task_url(@task), params: { task: { title: "#{ @task.title } (updated)" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Task was successfully updated."
  end

  test "can delete a task" do
    log_in(@user)
    get task_url(@task)
    assert_response :success
  
    delete task_url(@task)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Task was successfully deleted."
  end

end