require "test_helper"

describe CountersController do
  it "should get new" do
    get :new
    assert_response :success
  end

  it "should get edit" do
    get :edit
    assert_response :success
  end

end
