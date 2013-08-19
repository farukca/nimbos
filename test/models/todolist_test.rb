require "test_helper"

describe Todolist do
  before do
    @todolist = Todolist.new
  end

  it "must be valid" do
    @todolist.valid?.must_equal true
  end
end
