module Biz
  class AdminBiz
    attr_accessor :errors

    def initialize
      @errors = []
      @parent_log = nil
    end

    def main_job
    end

    def operation_job(job_name)
      return if $redis.get(:server_import_flag) == 'running'
      $redis.set(:server_import_flag, 'running')
      @parent_log = log job_name
      server_log '[job start] ' + job_name
      yield
      $redis.set(:server_import_flag, '')
      server_log('[job_end] ' + job_name)
    end
    def operation_each(query)
      qry_count = query.count
      qry_idx = 0
      op_id = 'op_' + rand(1..999999).to_s
      query.each do |row|
        yield row
        server_log(":% #{op_id} #{qry_count} #{qry_idx}")
        qry_idx += 1
      end
    end

    def log(title, detail = nil, puts_to_server: false)
      server_log(title) if puts_to_server

      log = Log.new
      log.log_title = title
      log.log_detail = detail
      log.level = 11
      log.parent = @parent_log
      log.save
      log
    end
    def server_log(msg)
      #puts msg
      $redis.lpush(:server_log, msg)
    end
  end
end
