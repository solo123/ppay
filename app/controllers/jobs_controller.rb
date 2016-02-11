class JobsController < AdminController
  def run_job
    if params[:job]
      flag = "server_import_flag"
      if $redis.get(flag) == 'running'
        log_detail("导入数据", "[取消] 上次导入尚未结束。", nil)
        $redis.lpush params[:job], "上次导入尚未结束..."
      else
        $redis.lpush params[:job], "h1: 0. 准备后台任务：#{params[:job]}..."
        job_name = params[:job] + '_job'
        job_name.classify.constantize.perform_later nil
      end
    end
  end
end
