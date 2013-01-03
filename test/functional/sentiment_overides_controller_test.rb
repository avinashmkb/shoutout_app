require 'test_helper'

class SentimentOveridesControllerTest < ActionController::TestCase
  setup do
    @sentiment_overide = sentiment_overides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sentiment_overides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sentiment_overide" do
    assert_difference('SentimentOveride.count') do
      post :create, sentiment_overide: @sentiment_overide.attributes
    end

    assert_redirected_to sentiment_overide_path(assigns(:sentiment_overide))
  end

  test "should show sentiment_overide" do
    get :show, id: @sentiment_overide
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sentiment_overide
    assert_response :success
  end

  test "should update sentiment_overide" do
    put :update, id: @sentiment_overide, sentiment_overide: @sentiment_overide.attributes
    assert_redirected_to sentiment_overide_path(assigns(:sentiment_overide))
  end

  test "should destroy sentiment_overide" do
    assert_difference('SentimentOveride.count', -1) do
      delete :destroy, id: @sentiment_overide
    end

    assert_redirected_to sentiment_overides_path
  end
end
