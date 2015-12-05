require 'test_helper'

class ImpLogsControllerTest < ActionController::TestCase
  setup do
    @imp_log = imp_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imp_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imp_log" do
    assert_difference('ImpLog.count') do
      post :create, imp_log: {  }
    end

    assert_redirected_to imp_log_path(assigns(:imp_log))
  end

  test "should show imp_log" do
    get :show, id: @imp_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imp_log
    assert_response :success
  end

  test "should update imp_log" do
    patch :update, id: @imp_log, imp_log: {  }
    assert_redirected_to imp_log_path(assigns(:imp_log))
  end

  test "should destroy imp_log" do
    assert_difference('ImpLog.count', -1) do
      delete :destroy, id: @imp_log
    end

    assert_redirected_to imp_logs_path
  end
end
