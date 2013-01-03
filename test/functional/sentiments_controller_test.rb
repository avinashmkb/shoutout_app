require 'test_helper'

class SentimentsControllerTest < ActionController::TestCase
  setup do
    @sentiment = sentiments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sentiments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sentiment" do
    assert_difference('Sentiment.count') do
      post :create, sentiment: @sentiment.attributes
    end

    assert_redirected_to sentiment_path(assigns(:sentiment))
  end

  test "should show sentiment" do
    get :show, id: @sentiment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sentiment
    assert_response :success
  end

  test "should update sentiment" do
    put :update, id: @sentiment, sentiment: @sentiment.attributes
    assert_redirected_to sentiment_path(assigns(:sentiment))
  end

  test "should destroy sentiment" do
    assert_difference('Sentiment.count', -1) do
      delete :destroy, id: @sentiment
    end

    assert_redirected_to sentiments_path
  end
end
