class ProcessForAgentJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    pre = Biz::PreProcess.new
    pre.process_client
    
  end
end
