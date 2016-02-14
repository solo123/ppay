require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  test "contract caculate profit" do
    c = contracts(:contract_amount1)
    assert_equal 5, c.caculate_profit(50)
    assert_equal 5.5,  c.caculate_profit(55)

    assert_equal 20, c.caculate_profit(100)
    assert_equal 24, c.caculate_profit(120)

    assert_equal 60, c.caculate_profit(200)
    assert_equal 72, c.caculate_profit(240)

    assert_equal 3000, c.caculate_profit(10000)
  end

  test "without contract profit" do
    c = contracts(:contract_amount2)
    assert_equal 0.0, c.caculate_profit(100)
  end
end
