require 'test_helper'

class ImpQfCustomersControllerTest < ActionController::TestCase
  setup do
    @imp_qf_customer = imp_qf_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imp_qf_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imp_qf_customer" do
    assert_difference('ImpQfCustomer.count') do
      post :create, imp_qf_customer: {  }
    end

    assert_redirected_to imp_qf_customer_path(assigns(:imp_qf_customer))
  end

  test "should show imp_qf_customer" do
    get :show, id: @imp_qf_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imp_qf_customer
    assert_response :success
  end

  test "should update imp_qf_customer" do
    patch :update, id: @imp_qf_customer, imp_qf_customer: {  }
    assert_redirected_to imp_qf_customer_path(assigns(:imp_qf_customer))
  end

  test "should destroy imp_qf_customer" do
    assert_difference('ImpQfCustomer.count', -1) do
      delete :destroy, id: @imp_qf_customer
    end

    assert_redirected_to imp_qf_customers_path
  end
end
