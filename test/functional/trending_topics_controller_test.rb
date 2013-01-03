require 'test_helper'

class TrendingTopicsControllerTest < ActionController::TestCase
  setup do
    @trending_topic = trending_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trending_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trending_topic" do
    assert_difference('TrendingTopic.count') do
      post :create, trending_topic: @trending_topic.attributes
    end

    assert_redirected_to trending_topic_path(assigns(:trending_topic))
  end

  test "should show trending_topic" do
    get :show, id: @trending_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trending_topic
    assert_response :success
  end

  test "should update trending_topic" do
    put :update, id: @trending_topic, trending_topic: @trending_topic.attributes
    assert_redirected_to trending_topic_path(assigns(:trending_topic))
  end

  test "should destroy trending_topic" do
    assert_difference('TrendingTopic.count', -1) do
      delete :destroy, id: @trending_topic
    end

    assert_redirected_to trending_topics_path
  end
end
