module Biz
  class ImportBiz
    def import_from_email
      begin
        import_from_email_unsafe
      rescue
        # handle the error
      ensure
        $redis.set(:qf_imp_flag, '导入结束')
      end
    end
    def import_from_email_unsafe
      require "net/imap"

      return if $redis.get(:qf_imp_flag) == 'running'
      $redis.set(:qf_imp_flag, 'running')

      get_new_emails().each do |uid|
        if ImpLog.find_by uid: uid
          ImpLog.new(uid: uid.to_i, detail: '[重复] skip...', status: 0).save
          next
        end
        implog = ImpLog.new(uid: uid.to_i)
        if check_email(uid, implog)
          att = get_attchement(uid)
          if att
            implog.detail << '[附件下载ok]'
            file_name = "tmp/#{uid}.xls"
            File.new(file_name, 'wb+').write(att.unpack('m')[0] )
            import_data(file_name, uid, implog)
          else
            implog.detail << '[没有附件]'
          end
        end
        implog.save
      end
    end

    def get_new_emails
      @imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
      @imap.login('qfqpos@pooul.cn', 'caI1111')
      @imap.select('inbox')

      since_time = "30-Nov-2014"
      if l = ImpLog.where(status: 8).first
        since_time = Net::IMAP.format_datetime(l.received_at.to_date) if l.received_at
      end
      @imap.search( ["SINCE", since_time ])
    end

    def check_email(uid, log)
      body = @imap.fetch(uid, "RFC822")[0].attr["RFC822"]
      mail = Mail.new(body)
      log.title = mail.subject
      log.received_at = mail.date
      log.mail_from = mail.from.kind_of?(Array) ? mail.from.join(',') : mail.from
      mail.has_attachments?
    end

    def get_attchement(id)
      attachment = @imap.fetch(id, "BODY[2]")[0].attr["BODY[2]"]
    end

    def import_data(data_file, id, log)
      puts "start import at #{data_file}"
      cus_attr = ['ssid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe', 'zt']
      trade_attr = ['ssid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']
      clear_attr = ['qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

      all_attrs = [cus_attr, trade_attr, clear_attr]

      begin
        book = Spreadsheet.open data_file
      rescue
        log.detail << '[无法打开文件]'
        log.status = '0'
      ensure

      end

      if book
        log.detail << '[格式正确]'
      else
        return
      end

      log.detail  << " 统计:"
      for sheetindex in 0..2 do

        sheet = book.worksheet sheetindex
        cnt = 0
        sheet.each  do |row|
          cnt += 1
          imp_data = get_model_with sheetindex
          i = 1
          next if row[1].nil? || row[1].to_i < 1

          for v in all_attrs[sheetindex] do
            theV = row[i]  || ' '
            imp_data.send( v + '=', theV)
            i += 1
          end

          imp_data.save
        end
        log.detail << 'sheet' + sheetindex.to_s + ':' + cnt.to_s + '  '
      end
      log.status = '8'
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
