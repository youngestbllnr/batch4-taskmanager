require "test_helper"

class MainControllerLoggedOutTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
  end

  test "should be able to view landing page when user is not logged in" do
    get root_url
    assert_response :success
  end

  test "should be able to view dashboard when user is not logged in" do
    get dashboard_url
    assert_response :redirect
  end

  test "should be able to view dev-mode pag when user is not logged in" do
    get dev_url
    assert_response :success
  end

  test "should not be able to view today page when user is not logged in" do
    log_in(@user)
    get today_url
    assert_response :success
  end
  
end