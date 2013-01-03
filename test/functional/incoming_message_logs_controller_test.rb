require 'test_helper'

class IncomingMessageLogsControllerTest < ActionController::TestCase
  setup do
    @incoming_message_log = incoming_message_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incoming_message_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incoming_message_log" do
    assert_difference('IncomingMessageLog.count') do
      post :create, incoming_message_log: @incoming_message_log.attributes
    end

    assert_redirected_to incoming_message_log_path(assigns(:incoming_message_log))
  end

  test "should show incoming_message_log" do
    get :show, id: @incoming_message_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incoming_message_log
    assert_response :success
  end

  test "should update incoming_message_log" do
    put :update, id: @incoming_message_log, incoming_message_log: @incoming_message_log.attributes
    assert_redirected_to incoming_message_log_path(assigns(:incoming_message_log))
  end

  test "should destroy incoming_message_log" do
    assert_difference('IncomingMessageLog.count', -1) do
      delete :destroy, id: @incoming_message_log
    end

    assert_redirected_to incoming_message_logs_path
  end
end
