require "test_helper"

describe Task do
  before do
    @task = Task.new
  end

  it "must be valid" do
    @task.valid?.must_equal true
  end
end
