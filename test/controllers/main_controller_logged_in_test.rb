require "test_helper"

class MainControllerLoggedInTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
    log_in(@user)
  end

  test "should view landing page when user is logged in" do
    get root_url
    assert_response :redirect
  end

  test "should be able to view dashboard when user is logged in" do
    get dashboard_url
    assert_response :success
  end

  test "should be able to view dev-mode pag when user is logged in" do
    get dev_url
    assert_response :success
  end

  test "should be able to view today page when user is logged in" do
    log_in(@user)
    get today_url
    assert_response :success
  end
  
end