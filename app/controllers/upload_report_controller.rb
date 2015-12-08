#require "#{Rails.root}/lib/tools/import_mail"

class UploadReportController < ApplicationController
#  include ImportMail

  layout 'import_data'

  def check
    if params[:query_data_type] = 'imp_qf_customer'
      @q = ImpQfCustomer.ransack(params[:q])
      @imp_cus = @q.result(distinct: true).page params[:imp_qf_customer_page]

    end

    @imp_log = ImpLog.page(params[:imp_log_page])

    @imp_op = ImpOp.page(params[:imp_op_page])

    # @imp_trade = ImpQfTrade.page params[:page]

  end

  def import
    import_from_email
    # 重定向到check path
    redirect_to upload_report_check_path
  end

  def import_from_email
    require "net/imap"

    imap = open_email
    ids = get_new_emails(imap)

    prelog = ImpLog.all.last
    preid = (prelog && prelog.envelop_uid.to_i) || 1

    ids.each do |id|
      next if id <= preid
      if check_email(imap, id)
      #  log 纪录邮件基础信息
      implog = ImpLog.find_or_create_by(envelop_uid: id.to_i)
      implog.envelop_uid = id


      att = get_attchement(imap, id, implog)
        if att
          file_name = "tmp/#{id}.xls"
          File.new(file_name,'wb+').write(att.unpack('m')[0] )
          import_data(file_name, id, implog)
        end
      end

      implog.save

    end
  end

  def open_email
    imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
    imap.login('qfqpos@pooul.cn', 'caI1111')
    imap.select('inbox')
    if imap
      # log
      log_op = ImpOp.new
      log_op.login_status = 'ok'
      log_op.save!

    end
    imap
  end

  def get_new_emails(imap)
    since_time = "30-Nov-2014"
    imap.search( ["SINCE", since_time ])
  end

  def check_email(imap, id)
    1
  end

  def get_attchement(imap, id, log)
    attachment = imap.fetch(id, "BODY[2]")[0].attr["BODY[2]"]
    log.load_file_status = attachment ? 'ok' : '没有下载成功'

    attachment
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
      log.open_file_status = '无法打开文件'
      log.process_status = '0'
    ensure

    end

    if book
      log.open_file_status = '格式正确'
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
        logger.warn row[4]

        for v in all_attrs[sheetindex] do
          theV = row[i]  || 'no value'
          imp_data.send( v + '=', theV)
          i += 1
        end
        imp_data.save
      end
      detail << 'sheet' + sheetindex.to_s + ':' + cnt.to_s + '  '


    end
    log.detail = detail
    log.process_status = '8'

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
