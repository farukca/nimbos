require "test_helper"

describe Listitem do
  before do
    @listitem = Listitem.new
  end

  it "must be valid" do
    @listitem.valid?.must_equal true
  end
end
