class TradesTotalsRecalJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::TradesTotalsBiz.new
    imp.re_total
  end
end
