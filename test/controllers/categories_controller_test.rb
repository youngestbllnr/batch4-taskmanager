require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @category = categories(:one)
    @task = tasks(:one)
    log_in(@user)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { description: @category.description, icon: @category.icon, title: @category.title, user: @user } }
    end

    assert_response :redirect
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { description: @category.description, icon: @category.icon, title: @category.title, user_id: @category.user_id } }
    assert_response :redirect
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_response :redirect
  end
end
