require "test_helper"

describe DiscussionsController do

  before do
    @discussion = discussions(:one)
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discussions)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create discussion" do
    assert_difference('Discussion.count') do
      post :create, discussion: {  }
    end

    assert_redirected_to discussion_path(assigns(:discussion))
  end

  it "must show discussion" do
    get :show, id: @discussion
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @discussion
    assert_response :success
  end

  it "must update discussion" do
    put :update, id: @discussion, discussion: {  }
    assert_redirected_to discussion_path(assigns(:discussion))
  end

  it "must destroy discussion" do
    assert_difference('Discussion.count', -1) do
      delete :destroy, id: @discussion
    end

    assert_redirected_to discussions_path
  end

end
