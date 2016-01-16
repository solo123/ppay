class TradesTotalsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    imp = Biz::TradesTotalsBiz.new
    imp.total_all
  end
end
