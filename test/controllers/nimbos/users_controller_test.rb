require "test_helper"

describe UsersController do
  it "should get new" do
    get :new
    assert_response :success
  end

end
