require "test_helper"

describe BranchesController do
  it "should get index" do
    get :index
    assert_response :success
  end

end
