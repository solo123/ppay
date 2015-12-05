require 'test_helper'

class ImpQfTradesControllerTest < ActionController::TestCase
  setup do
    @imp_qf_trade = imp_qf_trades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imp_qf_trades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imp_qf_trade" do
    assert_difference('ImpQfTrade.count') do
      post :create, imp_qf_trade: {  }
    end

    assert_redirected_to imp_qf_trade_path(assigns(:imp_qf_trade))
  end

  test "should show imp_qf_trade" do
    get :show, id: @imp_qf_trade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imp_qf_trade
    assert_response :success
  end

  test "should update imp_qf_trade" do
    patch :update, id: @imp_qf_trade, imp_qf_trade: {  }
    assert_redirected_to imp_qf_trade_path(assigns(:imp_qf_trade))
  end

  test "should destroy imp_qf_trade" do
    assert_difference('ImpQfTrade.count', -1) do
      delete :destroy, id: @imp_qf_trade
    end

    assert_redirected_to imp_qf_trades_path
  end
end
