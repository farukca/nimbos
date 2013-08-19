require "test_helper"

class BetausersControllerTest < ActionController::TestCase

  before do
    @betauser = betausers(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:betausers)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Betauser.count') do
      post :create, betauser: {  }
    end

    assert_redirected_to betauser_path(assigns(:betauser))
  end

  def test_show
    get :show, id: @betauser
    assert_response :success
  end

  def test_edit
    get :edit, id: @betauser
    assert_response :success
  end

  def test_update
    put :update, id: @betauser, betauser: {  }
    assert_redirected_to betauser_path(assigns(:betauser))
  end

  def test_destroy
    assert_difference('Betauser.count', -1) do
      delete :destroy, id: @betauser
    end

    assert_redirected_to betausers_path
  end
end
