#require "#{Rails.root}/lib/tools/import_mail"

class UploadReportController < ApplicationController
#  include ImportMail

  def check
    @q = ImpQfCustomer.ransack(params[:q])
    @imp_cus = @q.result(distinct: true).page params[:page]

    @imp_trade = ImpQfTrade.page params[:page]

    @imp_log = ImpLog.page params[:page]
  end

  def upload
    import_from_mail
  end
  def import_from_mail
    require "net/imap"
    imap = open_email
    ids = get_new_emails(imap)
    ids.each do |id|
     if check_email(imap, id)
       att = get_attchement(imap, id)
       if att
         file_name = "tmp/import_#{id}.xls"
         File.new(file_name,'wb+').write(att.unpack('m')[0] )
         import_data(file_name)
       end
     end
    end
  end

  def open_email
    imap = Net::IMAP.new 'imap.qq.com', 993, true, nil, false
    imap.login('qfqpos@pooul.cn', 'caI1111')
    imap.select('inbox')
    imap
  end

  def get_new_emails(imap)
    since_time = "30-Nov-2015"
    imap.search( ["SINCE", since_time ])
  end
  def check_email(imap, id)
    1
  end
  def get_attchement(imap, id)
    attachment = imap.fetch(id, "BODY[2]")[0].attr["BODY[2]"]
  end
  def import_data(data_file)
    puts "start import at #{data_file}"
    cus_attr = ['ssid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe', 'zt']
    trade_attr = ['ssid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']
    clear_attr = ['qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

    all_attrs = [cus_attr, trade_attr, clear_attr]

    book = Spreadsheet.open data_file
    if book == nil
      return
    end

    for sheetindex in 0..2 do

      sheet = book.worksheet sheetindex

      sheet.each  do |row|

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


    end

    logger.warn '测试数据导入成功'

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
