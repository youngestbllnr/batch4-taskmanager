require "test_helper"

class MainControllerLoggedInTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
    log_in(@user)
  end

  test "should redirect tp dasjhboard from landing page when user is logged in" do
    get root_url
    assert_response :redirect
  end

  test "should get dashboard when user is logged in" do
    get dashboard_url
    assert_response :success
  end

  test "should get dev-mode pag when user is logged in" do
    get dev_url
    assert_response :success
  end

  test "should get today page when user is logged in" do
    get today_url
    assert_response :success
  end
  
end