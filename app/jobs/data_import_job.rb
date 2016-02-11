class DataImportJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::DataImportBiz.new
    imp.main_job
  end
end
