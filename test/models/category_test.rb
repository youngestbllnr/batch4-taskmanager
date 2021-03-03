require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  test "should not save when icon is blank" do
    category = Category.new(icon: "", title: "Sample Category", description: "This is a sample category.")
    assert_not category.save
  end

  test "should not save when icon is not present" do
    category = Category.new(title: "Sample Category", description: "This is a sample category.")
    assert_not category.save
  end
  
  test "should not save when title is blank" do
    category = Category.new(icon: "🔖", title: "", description: "This is a sample category.")
    assert_not category.save
  end

  test "should not save when title is not present" do
    category = Category.new(icon: "🔖", description: "This is a sample category.")
    assert_not category.save
  end

  test "should not save when description is blank" do
    category = Category.new(icon: "🔖", title: "Sample Category", description: "")
    assert_not category.save
  end

  test "should not save when description is not present" do
    category = Category.new(icon: "🔖", title: "Sample Category")
    assert_not category.save
  end

  test "should save when everything is awesome" do
    category = Category.new(icon: "🔖", title: "Sample Category", description: "This is a sample category.")
    assert category.save
  end

end
