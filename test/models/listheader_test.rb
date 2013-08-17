require "test_helper"

describe Listheader do
  before do
    @listheader = Listheader.new
  end

  it "must be valid" do
    @listheader.valid?.must_equal true
  end
end
