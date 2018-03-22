require 'test_helper'

class TraidLogsControllerTest < ActionController::TestCase
  setup do
    @traid_log = traid_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:traid_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create traid_log" do
    assert_difference('TraidLog.count') do
      post :create, traid_log: {  }
    end

    assert_redirected_to traid_log_path(assigns(:traid_log))
  end

  test "should show traid_log" do
    get :show, id: @traid_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @traid_log
    assert_response :success
  end

  test "should update traid_log" do
    patch :update, id: @traid_log, traid_log: {  }
    assert_redirected_to traid_log_path(assigns(:traid_log))
  end

  test "should destroy traid_log" do
    assert_difference('TraidLog.count', -1) do
      delete :destroy, id: @traid_log
    end

    assert_redirected_to traid_logs_path
  end
end
