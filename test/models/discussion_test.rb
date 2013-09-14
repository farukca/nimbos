require "test_helper"

describe Discussion do
  before do
    @discussion = Discussion.new
  end

  it "must be valid" do
    @discussion.valid?.must_equal true
  end
end
