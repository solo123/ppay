module Biz
  class GetQfEmailsBiz < AdminBiz
    def main_job
      operation_job('从email中导入QF数据') do
        begin
          import_from_email_unsafe
        rescue Exception => e
          log '读取邮件出错:' + e.message, e.backtrace.inspect
        end
      end
    end

    def import_from_email_unsafe
      require "net/imap"

      get_new_emails.each do |uid|
        if ImpLog.where('status>0').find_by(uid: uid)
          log ":b 重复邮件[#{uid}]", puts_to_server: true
          next
        end
        implog = ImpLog.find_or_create_by(uid: uid.to_i, status: 0)
        implog.save
        mail = check_email(uid, implog)
        if mail.has_attachments?
          mail.attachments.each do |att|
            origin_filename = att.filename.strip
            file_ext = File.extname(origin_filename).downcase
            next unless file_ext.start_with?('.xls')
            dir_name = 'tmp/qf_xls'
            file_name = "#{dir_name}/#{uid}#{file_ext}"
            FileUtils.mkdir_p(dir_name) unless File.directory?(dir_name)
            File.new(file_name, 'wb+').write(att.decoded)
            implog.origin_filename = origin_filename
            implog.filename = file_name
            implog.status = 1
            log "附件下载成功", puts_to_server: true
            break
          end
        end
        implog.save
      end
    end

    def get_new_emails
      @email = 'qfqpos@pooul.cn'
      @email_pass = 'caI1111'
      @imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
      @imap.login(@email, @email_pass)
      @imap.select('inbox')

      since_time = "30-Nov-2014"
      if l = ImpLog.where('status>0').last
        since_time = Net::IMAP.format_datetime(l.received_at.to_date) if l.received_at
      end
      log "读取日期#{since_time}之后的新邮件", puts_to_server: true
      @imap.search( ["SINCE", since_time ])
    end

    def check_email(uid, implog)
      body = @imap.fetch(uid, "RFC822")[0].attr["RFC822"]
      mail = Mail.new(body)
      implog.title = mail.subject
      implog.received_at = mail.date
      implog.mail_from = mail.from.kind_of?(Array) ? mail.from.join(',') : mail.from
      log "邮件：#{implog.title}，来自：#{implog.mail_from} @ #{implog.received_at}", puts_to_server: true
      mail
    end

  end
end
