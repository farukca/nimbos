require "test_helper"

describe Activity do
  before do
    @activity = Activity.new
  end

  it "must be valid" do
    @activity.valid?.must_equal true
  end
end
