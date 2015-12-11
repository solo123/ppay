require 'test_helper'

class ImpOpsControllerTest < ActionController::TestCase
  setup do
    @imp_op = imp_ops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imp_ops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imp_op" do
    assert_difference('ImpOp.count') do
      post :create, imp_op: {  }
    end

    assert_redirected_to imp_op_path(assigns(:imp_op))
  end

  test "should show imp_op" do
    get :show, id: @imp_op
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imp_op
    assert_response :success
  end

  test "should update imp_op" do
    patch :update, id: @imp_op, imp_op: {  }
    assert_redirected_to imp_op_path(assigns(:imp_op))
  end

  test "should destroy imp_op" do
    assert_difference('ImpOp.count', -1) do
      delete :destroy, id: @imp_op
    end

    assert_redirected_to imp_ops_path
  end
end
