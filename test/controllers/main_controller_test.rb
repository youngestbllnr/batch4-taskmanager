require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  
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

  test "should redirect from today page when user is not logged in" do
    get today_url
    assert_response :redirect
  end

  test "should redirect tp dashboard from landing page when user is logged in" do
    log_in(@user)
    get root_url
    assert_response :redirect
  end

  test "should get dashboard when user is logged in" do
    log_in(@user)
    get dashboard_url
    assert_response :success
  end

  test "should get today page when user is logged in" do
    log_in(@user)
    get today_url
    assert_response :success
  end
  
end