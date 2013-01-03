require 'test_helper'

class SmsalertChecksControllerTest < ActionController::TestCase
  setup do
    @smsalert_check = smsalert_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:smsalert_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create smsalert_check" do
    assert_difference('SmsalertCheck.count') do
      post :create, smsalert_check: @smsalert_check.attributes
    end

    assert_redirected_to smsalert_check_path(assigns(:smsalert_check))
  end

  test "should show smsalert_check" do
    get :show, id: @smsalert_check
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @smsalert_check
    assert_response :success
  end

  test "should update smsalert_check" do
    put :update, id: @smsalert_check, smsalert_check: @smsalert_check.attributes
    assert_redirected_to smsalert_check_path(assigns(:smsalert_check))
  end

  test "should destroy smsalert_check" do
    assert_difference('SmsalertCheck.count', -1) do
      delete :destroy, id: @smsalert_check
    end

    assert_redirected_to smsalert_checks_path
  end
end
