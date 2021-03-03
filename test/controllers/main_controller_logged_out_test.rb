require "test_helper"

class MainControllerLoggedOutTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = users(:one)
  end

  test "should get landing page when user is not logged in" do
    get root_url
    assert_response :success
  end

  test "should redirect from dashboard when user is not logged in" do
    get dashboard_url
    assert_response :redirect
  end

  test "should get dev-mode pag when user is not logged in" do
    get dev_url
    assert_response :success
  end

  test "should redirect from today page when user is not logged in" do
    get today_url
    assert_response :redirect
  end
  
end