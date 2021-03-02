require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should toggle task is_checked_field" do
    get toggle_task_url(task_id: @task.id)
    assert_response :redirect
  end
end