require "test_helper"

describe Country do
  before do
    @country = Country.new
  end

  it "must be valid" do
    @country.valid?.must_equal true
  end
end
