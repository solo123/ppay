module Biz
  class ParseExcelBiz < AdminBiz
    def initialize
      super
      @parse_biz = ParseXlsBiz.new
    end

    def main_job
      operation_job('导入Excel文件中的数据') do
        qry = ImpLog.where(status: 1)
        operation_each(qry) do |l|
          import_data(l)
        end
      end
    end

    def import_data(implog)
      if implog.status == 8
        log "该日数据已经从excel中导入。"
        return
      end
      unless implog.status == 1
        implog.status = 0
        implog.save
        log "imp_log中状态不对。"
        return
      end
      error_message = nil
      if implog.filename && File.exists?(implog.filename)
        log "数据文件：" + implog.filename
        ext = File.extname(implog.filename)
        if ext == '.xls'
          @parse_biz.do_parse_xls(implog)
        else
          @parse_biz.do_parse_xlsx(implog)
        end
      else
        log "数据文件没有找到！#{implog.filename}"
      end
      if @parse_biz.error_message
        implog.detail << '[无法打开文件]' << @parse_biz.error_message
        implog.status = '0'
        implog.save
        log "无法打开excel文件", @parse_biz.error_message
      else
        implog.detail << '[格式正确]'
        implog.status = 8
      end
      implog.save
    end
  end
end
