require "test_helper"

class FeedbacksControllerTest < ActionController::TestCase

  before do
    @feedback = feedbacks(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:feedbacks)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Feedback.count') do
      post :create, feedback: {  }
    end

    assert_redirected_to feedback_path(assigns(:feedback))
  end

  def test_show
    get :show, id: @feedback
    assert_response :success
  end

  def test_edit
    get :edit, id: @feedback
    assert_response :success
  end

  def test_update
    put :update, id: @feedback, feedback: {  }
    assert_redirected_to feedback_path(assigns(:feedback))
  end

  def test_destroy
    assert_difference('Feedback.count', -1) do
      delete :destroy, id: @feedback
    end

    assert_redirected_to feedbacks_path
  end
end
