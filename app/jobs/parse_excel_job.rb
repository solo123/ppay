class ParseExcelJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    imp = Biz::ParseExcelBiz.new
    imp.main_job
  end
end
