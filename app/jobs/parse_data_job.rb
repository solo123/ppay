class ParseDataJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::ParseDataBiz.new
    imp.parseCustomers
  end
end
