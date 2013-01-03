require 'test_helper'

class AiaiooFailuresControllerTest < ActionController::TestCase
  setup do
    @aiaioo_failure = aiaioo_failures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aiaioo_failures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aiaioo_failure" do
    assert_difference('AiaiooFailure.count') do
      post :create, aiaioo_failure: @aiaioo_failure.attributes
    end

    assert_redirected_to aiaioo_failure_path(assigns(:aiaioo_failure))
  end

  test "should show aiaioo_failure" do
    get :show, id: @aiaioo_failure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aiaioo_failure
    assert_response :success
  end

  test "should update aiaioo_failure" do
    put :update, id: @aiaioo_failure, aiaioo_failure: @aiaioo_failure.attributes
    assert_redirected_to aiaioo_failure_path(assigns(:aiaioo_failure))
  end

  test "should destroy aiaioo_failure" do
    assert_difference('AiaiooFailure.count', -1) do
      delete :destroy, id: @aiaioo_failure
    end

    assert_redirected_to aiaioo_failures_path
  end
end
