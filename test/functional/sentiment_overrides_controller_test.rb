require 'test_helper'

class SentimentOverridesControllerTest < ActionController::TestCase
  setup do
    @sentiment_override = sentiment_overrides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sentiment_overrides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sentiment_override" do
    assert_difference('SentimentOverride.count') do
      post :create, sentiment_override: @sentiment_override.attributes
    end

    assert_redirected_to sentiment_override_path(assigns(:sentiment_override))
  end

  test "should show sentiment_override" do
    get :show, id: @sentiment_override
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sentiment_override
    assert_response :success
  end

  test "should update sentiment_override" do
    put :update, id: @sentiment_override, sentiment_override: @sentiment_override.attributes
    assert_redirected_to sentiment_override_path(assigns(:sentiment_override))
  end

  test "should destroy sentiment_override" do
    assert_difference('SentimentOverride.count', -1) do
      delete :destroy, id: @sentiment_override
    end

    assert_redirected_to sentiment_overrides_path
  end
end
