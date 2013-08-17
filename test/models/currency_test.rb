require "test_helper"

describe Currency do
  before do
    @currency = Currency.new
  end

  it "must be valid" do
    @currency.valid?.must_equal true
  end
end
