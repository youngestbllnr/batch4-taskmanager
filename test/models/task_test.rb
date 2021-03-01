require "test_helper"

class TaskTest < ActiveSupport::TestCase

  test "should not save when title is blank" do
    task = Task.new(title: "", description: "This is a sample task.")
    assert_not task.save
  end

  test "should not save when title is not present" do
    task = Task.new(description: "This is a sample task.")
    assert_not task.save
  end

  test "should not save when description is blank" do
    task = Task.new(title: "Sample Task", description: "")
    assert_not task.save
  end

  test "should not save when description is not present" do
    task = Task.new(title: "Sample Task")
    assert_not task.save
  end

  test "should save when everything is awesome" do
    task = Task.new(title: "Sample Task", description: "This is a sample task.")
    assert task.save
  end

end
