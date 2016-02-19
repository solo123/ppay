module ReportsHelper
  def trade_value(objs, trade_type, attr)
    obj = objs.find{|t| t.trade_type == trade_type}
    if obj && obj.has_attribute?(attr)
      if attr == :amount
        n2 obj[attr]
      else
        n0 obj[attr]
      end
    else
      nil
    end
  end
end
