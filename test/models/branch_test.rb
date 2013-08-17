require "test_helper"

describe Branch do
  before do
    @branch = Branch.new
  end

  it "must be valid" do
    @branch.valid?.must_equal true
  end
end
