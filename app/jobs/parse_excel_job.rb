class ParseExcelJob < ActiveJob::Base
  queue_as :default
  def perform(*args)
    biz = Biz::ImportBiz.new
    ImpLog.where(status: 1).each do |log|
      biz.import_data(log)
    end
  end
end
