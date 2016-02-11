class GetQfEmailsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::GetQfEmailsBiz.new
    imp.main_job
  end
end
