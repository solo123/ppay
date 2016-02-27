class JobsController < AdminController
  def run_job
    if params[:job]
      flag = "server_import_flag"
      if $redis.get(flag) == 'running'
        log_detail("导入数据", "[取消] 上次导入尚未结束。", nil)
        $redis.lpush :server_log, "上次处理尚未结束..."
      else
        $redis.lpush :server_log, ":h3 准备后台任务：#{params[:job]}..."
        DataOperateJob.perform_later params[:job]
      end
    end
  end
end
