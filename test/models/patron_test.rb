require "test_helper"

describe Patron do
  before do
    @patron = Patron.new
  end

  it "must be valid" do
    @patron.valid?.must_equal true
  end
end
