require 'test_helper'

class FeedbackCategoriesControllerTest < ActionController::TestCase
  setup do
    @feedback_category = feedback_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feedback_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feedback_category" do
    assert_difference('FeedbackCategory.count') do
      post :create, feedback_category: @feedback_category.attributes
    end

    assert_redirected_to feedback_category_path(assigns(:feedback_category))
  end

  test "should show feedback_category" do
    get :show, id: @feedback_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feedback_category
    assert_response :success
  end

  test "should update feedback_category" do
    put :update, id: @feedback_category, feedback_category: @feedback_category.attributes
    assert_redirected_to feedback_category_path(assigns(:feedback_category))
  end

  test "should destroy feedback_category" do
    assert_difference('FeedbackCategory.count', -1) do
      delete :destroy, id: @feedback_category
    end

    assert_redirected_to feedback_categories_path
  end
end
