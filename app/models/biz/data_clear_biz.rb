module Biz
  class DataClearBiz
    def clear_data_after(start_date_string)
      d = Time.zone.parse(start_date_string)
      Trade.where('trade_date>?', d).delete_all
      Clearing.where('trade_date>?', start_date_string).delete_all
      TradeSum.where('trade_date>?', start_date_string).delete_all
    end

    def clear_import_after(implog_id)
      ImpLog.where('id>?', implog_id).update_all(detail: '')
      ImpQfCustomer.where('imp_log_id>?', implog_id).delete_all
      ImpQfTrade.where('imp_log_id>?', implog_id).delete_all
      ImpQfClearing.where('imp_log_id>?', implog_id).delete_all
    end
  end
end
