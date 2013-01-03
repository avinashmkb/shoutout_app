require 'test_helper'

class OutgoingMessageLogsControllerTest < ActionController::TestCase
  setup do
    @outgoing_message_log = outgoing_message_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outgoing_message_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outgoing_message_log" do
    assert_difference('OutgoingMessageLog.count') do
      post :create, outgoing_message_log: @outgoing_message_log.attributes
    end

    assert_redirected_to outgoing_message_log_path(assigns(:outgoing_message_log))
  end

  test "should show outgoing_message_log" do
    get :show, id: @outgoing_message_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outgoing_message_log
    assert_response :success
  end

  test "should update outgoing_message_log" do
    put :update, id: @outgoing_message_log, outgoing_message_log: @outgoing_message_log.attributes
    assert_redirected_to outgoing_message_log_path(assigns(:outgoing_message_log))
  end

  test "should destroy outgoing_message_log" do
    assert_difference('OutgoingMessageLog.count', -1) do
      delete :destroy, id: @outgoing_message_log
    end

    assert_redirected_to outgoing_message_logs_path
  end
end
