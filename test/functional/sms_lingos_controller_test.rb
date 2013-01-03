require 'test_helper'

class SmsLingosControllerTest < ActionController::TestCase
  setup do
    @sms_lingo = sms_lingos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sms_lingos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sms_lingo" do
    assert_difference('SmsLingo.count') do
      post :create, sms_lingo: @sms_lingo.attributes
    end

    assert_redirected_to sms_lingo_path(assigns(:sms_lingo))
  end

  test "should show sms_lingo" do
    get :show, id: @sms_lingo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sms_lingo
    assert_response :success
  end

  test "should update sms_lingo" do
    put :update, id: @sms_lingo, sms_lingo: @sms_lingo.attributes
    assert_redirected_to sms_lingo_path(assigns(:sms_lingo))
  end

  test "should destroy sms_lingo" do
    assert_difference('SmsLingo.count', -1) do
      delete :destroy, id: @sms_lingo
    end

    assert_redirected_to sms_lingos_path
  end
end
