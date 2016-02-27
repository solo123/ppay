class DataOperateJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    case args[0].to_sym
    when :get_qf_emails
      Biz::GetQfEmailsBiz.new.main_job
    when :parse_excel
      Biz::ParseExcelBiz.new.main_job
    when :data_import
      Biz::DataImportBiz.new.main_job
    when :trades_totals
      Biz::TradesTotalsBiz.new.main_job
    when :recaculate_month
      Biz::TradesTotalsBiz.new.re_total_job
    else
    end
  end
end
