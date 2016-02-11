class TradesTotalsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::TradesTotalsBiz.new
    imp.main_job
  end
end
