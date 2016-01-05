class StatisticsDataJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::StatisticsDataJob.new
    imp.statistics_all
  end
end
