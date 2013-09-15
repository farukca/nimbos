require "test_helper"

describe Counter do
  before do
    @counter = Counter.new
  end

  it "must be valid" do
    @counter.valid?.must_equal true
  end
end
