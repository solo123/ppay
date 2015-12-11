module Biz
  class ImportBiz

    def import_from_email
      require "net/imap"

      return if $redis.get(:qf_imp_flag) == 'running'
      $redis.set(:qf_imp_flag, 'running')

      open_email
      @ids = get_new_emails

      prelog = ImpLog.all.last
      preid = (prelog && prelog.envelop_uid.to_i) || 1

      @ids.each do |id|
        if id <= preid
          ImpLog.new(envelop_uid: id.to_i, detail: 'skip...').save
          next
        end
        @implog = ImpLog.new(envelop_uid: id.to_i)
        if check_email(id)
          #  log 纪录邮件基础信息
          att = get_attchement(id)
          if att
            @implog.load_file_status = '附件下载成功' : '没有下载成功'
            file_name = "tmp/#{id}.xls"
            File.new(file_name, 'wb+').write(att.unpack('m')[0] )
            import_data(file_name, id)
          else
            @implog.load_file_status = '没有附件'
          end
        end
        @implog.save
      end
      $redis.set(:qf_imp_flag, '')
    end

    def open_email
      @imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
      @imap.login('qfqpos@pooul.cn', 'caI1111')
      @imap.select('inbox')
    end

    def get_new_emails
      since_time = "30-Nov-2014"
      @imap.search( ["SINCE", since_time ])
    end

    def check_email(id)
      1
    end

    def get_attchement(id)
      attachment = @imap.fetch(id, "BODY[2]")[0].attr["BODY[2]"]
    end

    def import_data(data_file, id)
      puts "start import at #{data_file}"
      cus_attr = ['ssid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe', 'zt']
      trade_attr = ['ssid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']
      clear_attr = ['qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

      all_attrs = [cus_attr, trade_attr, clear_attr]

      begin
        book = Spreadsheet.open data_file
      rescue
        @implog.open_file_status = '无法打开文件'
        @implog.process_status = '0'
      ensure

      end

      if book
        @implog.open_file_status = '格式正确'
      else
        return
      end

      detail  = "统计:"
      for sheetindex in 0..2 do

        sheet = book.worksheet sheetindex
        cnt = 0
        sheet.each  do |row|
          cnt += 1
          imp_data = get_model_with sheetindex
          i = 1
          #logger.warn row[4]

          for v in all_attrs[sheetindex] do
            theV = row[i]  || 'no value'
            imp_data.send( v + '=', theV)
            i += 1
          end
          imp_data.save
        end
        detail << 'sheet' + sheetindex.to_s + ':' + cnt.to_s + '  '


      end
      @implog.detail = detail
      @implog.process_status = '8'

    end

    def get_model_with(index)
      obj = nil
      if index == 0
        obj = ImpQfCustomer.new
      end
      if index == 1
        obj = ImpQfTrade.new
      end
      if index == 2
        obj = ImpQfClearing.new
      end

      return obj
    end

  end
end
