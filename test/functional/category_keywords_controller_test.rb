require 'test_helper'

class CategoryKeywordsControllerTest < ActionController::TestCase
  setup do
    @category_keyword = category_keywords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_keywords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_keyword" do
    assert_difference('CategoryKeyword.count') do
      post :create, category_keyword: @category_keyword.attributes
    end

    assert_redirected_to category_keyword_path(assigns(:category_keyword))
  end

  test "should show category_keyword" do
    get :show, id: @category_keyword
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_keyword
    assert_response :success
  end

  test "should update category_keyword" do
    put :update, id: @category_keyword, category_keyword: @category_keyword.attributes
    assert_redirected_to category_keyword_path(assigns(:category_keyword))
  end

  test "should destroy category_keyword" do
    assert_difference('CategoryKeyword.count', -1) do
      delete :destroy, id: @category_keyword
    end

    assert_redirected_to category_keywords_path
  end
end
