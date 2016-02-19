require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  test "agent caculate profit" do
    a = agents(:agent1)
    assert a.contracts.count > 0

    assert_equal 5, a.profit(50, 'wechat')
    assert_equal 5.5,  a.profit(55, 'wechat')

    assert_equal 20, a.profit(100, 'wechat')
    assert_equal 24, a.profit(120, 'wechat')

    assert_equal 60, a.profit(200, 'wechat')
    assert_equal 72, a.profit(240, 'wechat')

    assert_equal 3000, a.profit(10000, 'wechat')
  end

  test 'agent profit 0 if not contract' do
    a = agents(:agent1)
    assert_equal 0, a.profit(1000, 'alipay')
  end

end
