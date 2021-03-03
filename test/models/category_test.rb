require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  setup do
    @user = users(:one)
  end

  test "should not save when icon is blank" do
    category = Category.new(icon: "", title: "Sample Category", description: "This is a sample category.", user: @user)
    assert_not category.save
  end

  test "should not save when icon is not present" do
    category = Category.new(title: "Sample Category", description: "This is a sample category.", user: @user)
    assert_not category.save
  end
  
  test "should not save when title is blank" do
    category = Category.new(icon: "🔖", title: "", description: "This is a sample category.", user: @user)
    assert_not category.save
  end

  test "should not save when title is not present" do
    category = Category.new(icon: "🔖", description: "This is a sample category.", user: @user)
    assert_not category.save
  end

  test "should not save when description is blank" do
    category = Category.new(icon: "🔖", title: "Sample Category", description: "", user: @user)
    assert_not category.save
  end

  test "should not save when description is not present" do
    category = Category.new(icon: "🔖", title: "Sample Category", user: @user)
    assert_not category.save
  end

  test "should save when everything is awesome" do
    category = Category.new(icon: "🔖", title: "Sample Category", description: "This is a sample category.", user: @user)
    assert category.save
  end

end
