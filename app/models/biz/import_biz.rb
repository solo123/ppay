module Biz
  class ImportBiz

    def import_from_email
      @errors = []
      # return if $redis.get(:qf_imp_flag) == 'running'
      $redis.set(:qf_imp_flag, 'running')
      slog ":h1 开始导入数据......"
      import_from_email_unsafe
      begin
      rescue
        # handle the error
        slog '[导入出错]'
        @errors << "[导入出错] ..."
      ensure
        $redis.set(:qf_imp_flag, '')
        slog ':h1 导入结束...'
        slog 'import_end'
      end
    end
    def import_from_email_unsafe
      require "net/imap"

      get_new_emails.each do |uid|
        slog uid
        if ImpLog.find_by uid: uid
          slog ":h1 重复邮件[#{uid}]"
          # ImpLog.new(uid: uid.to_i, detail: '[重复] skip...', status: 0).save
          next
        end
        implog = ImpLog.new(uid: uid.to_i)
        implog.save
        if check_email(uid, implog)
          att = get_attchement(uid)
          if att
            file_name = "tmp/#{uid}.xls"
            File.new(file_name, 'wb+').write(att.unpack('m')[0] )
            implog.detail << '[附件下载ok]'
            slog "    附件下载成功"

            import_data(file_name, implog)
          else
            implog.detail << '[没有附件]'
            slog "    没有附件。"
          end
        end
        implog.save
      end
    end

    def get_new_emails
      slog "> 正在读取邮件."
      @imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
      @imap.login('qfqpos@pooul.cn', 'caI1111')
      @imap.select('inbox')

      since_time = "30-Nov-2014"
      if l = ImpLog.first
        since_time = Net::IMAP.format_datetime(l.received_at.to_date) if l.received_at
      end
      slog "读取日期#{since_time}之后的新邮件"
      @imap.search( ["SINCE", since_time ])
    end

    def check_email(uid, log)
      body = @imap.fetch(uid, "RFC822")[0].attr["RFC822"]
      mail = Mail.new(body)
      log.title = mail.subject
      log.received_at = mail.date
      log.mail_from = mail.from.kind_of?(Array) ? mail.from.join(',') : mail.from
      slog ":h1 邮件：#{log.title}，来自：#{log.mail_from} @ #{log.received_at}"
      mail.has_attachments?
    end

    def get_attchement(id)
      attachment = @imap.fetch(id, "BODY[2]")[0].attr["BODY[2]"]
    end

    def import_data(data_file, log)
      slog "start import at #{data_file}"
      cus_attr = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe', 'zt']
      trade_attr = ['shid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']
      clear_attr = ['shid', 'qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

      all_attrs = [cus_attr, trade_attr, clear_attr]

      begin
        book = Spreadsheet.open data_file
      rescue
        log.detail << '[无法打开文件]'
        log.status = '0'
        slog "无法打开文件#{data_file}"
      ensure

      end

      if book
        log.detail << '[格式正确]'
        slog "格式正确"
      else
        return
      end

      import_qf_clients(book, log)
      import_qf_trades(book, log)
      import_qf_clearing(book, log)
      log.status = '8'
    end


    def import_qf_clients(xsl_file, log)
      slog "正在导入[商户资料]表"
      attrs = []
      if log.received_at < '2016-01-20'
        attrs = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
      else
        attrs = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'shzt', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
      end
      cnt = 0
      sheet = xsl_file.worksheet 0
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = ImpQfCustomer.new
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.imp_log_id = log.id
        imp.save
        cnt += 1
      end

      log.detail << '商户资料:' + cnt.to_s + ', '
      slog log.detail
    end

    def import_qf_trades(xsl_file, log)
      slog "正在导入[交易]表"
      attrs = ['shid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']

      cnt = 0
      sheet = xsl_file.worksheet 1
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = ImpQfTrade.new
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.imp_log_id = log.id
        imp.save
        cnt += 1
      end

      log.detail << "交易:#{cnt}, "
      slog log.detail
    end

    def import_qf_clearing(xsl_file, log)
      slog "正在导入[清算]表"
      attrs = ['shid', 'qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

      cnt = 0
      sheet = xsl_file.worksheet 2
      sheet.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        imp = ImpQfClearing.new
        attrs.each_with_index do |att, idx|
          imp[att] = row[idx + 1]
        end
        imp.imp_log_id = log.id
        imp.save
        cnt += 1
      end

      log.detail << "清算:#{cnt}"
      slog log.detail
    end

    def slog(msg)
      puts msg
      $redis.lpush(:import_log, msg)
    end

  end
end
