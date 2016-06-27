class LogsController < ApplicationController
  def index
    @collection = Log.show_order.page(params[:page]).per(100)
  end

  def get_log_msg
    log_name = params[:log_name]
    r = []
    while (msg = $redis.rpop(:server_log))
      r << msg
    end
    render text: r.join('|').html_safe
  end
end
