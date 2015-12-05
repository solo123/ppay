require 'test_helper'

class ImpQfClearingsControllerTest < ActionController::TestCase
  setup do
    @imp_qf_clearing = imp_qf_clearings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imp_qf_clearings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imp_qf_clearing" do
    assert_difference('ImpQfClearing.count') do
      post :create, imp_qf_clearing: {  }
    end

    assert_redirected_to imp_qf_clearing_path(assigns(:imp_qf_clearing))
  end

  test "should show imp_qf_clearing" do
    get :show, id: @imp_qf_clearing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imp_qf_clearing
    assert_response :success
  end

  test "should update imp_qf_clearing" do
    patch :update, id: @imp_qf_clearing, imp_qf_clearing: {  }
    assert_redirected_to imp_qf_clearing_path(assigns(:imp_qf_clearing))
  end

  test "should destroy imp_qf_clearing" do
    assert_difference('ImpQfClearing.count', -1) do
      delete :destroy, id: @imp_qf_clearing
    end

    assert_redirected_to imp_qf_clearings_path
  end
end
