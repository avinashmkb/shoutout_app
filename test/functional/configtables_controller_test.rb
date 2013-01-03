require 'test_helper'

class ConfigtablesControllerTest < ActionController::TestCase
  setup do
    @configtable = configtables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:configtables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create configtable" do
    assert_difference('Configtable.count') do
      post :create, configtable: @configtable.attributes
    end

    assert_redirected_to configtable_path(assigns(:configtable))
  end

  test "should show configtable" do
    get :show, id: @configtable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @configtable
    assert_response :success
  end

  test "should update configtable" do
    put :update, id: @configtable, configtable: @configtable.attributes
    assert_redirected_to configtable_path(assigns(:configtable))
  end

  test "should destroy configtable" do
    assert_difference('Configtable.count', -1) do
      delete :destroy, id: @configtable
    end

    assert_redirected_to configtables_path
  end
end
