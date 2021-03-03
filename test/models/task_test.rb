require "test_helper"

class TaskTest < ActiveSupport::TestCase

  setup do
    @category = categories(:one)
  end

  test "should not save when title is blank" do
    task = Task.new(title: "", description: "This is a sample task.", category: @category)
    assert_not task.save
  end

  test "should not save when title is not present" do
    task = Task.new(description: "This is a sample task.", category: @category)
    assert_not task.save
  end

  test "should not save when description is blank" do
    task = Task.new(title: "Sample Task", description: "", category: @category)
    assert_not task.save
  end

  test "should not save when description is not present" do
    task = Task.new(title: "Sample Task", category: @category)
    assert_not task.save
  end

  test "should save when everything is awesome" do
    task = Task.new(title: "Sample Task", description: "This is a sample task.", category: @category)
    assert task.save
  end

end
