

module ImportMail

  def hello
    for i in 1..100 do
      puts '=' * 42
    end
  end

  def download_email
    path_dir = Rails.root.join('public', 'uploads')

    logger.debug path_dir.to_s
    paths = loadattachment_to path_dir # 下载附件

    puts paths
    for file in paths do
      import_data file
    end

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

  def loadattachment_to(path_dir)
    require "net/imap"

    imap = Net::IMAP.new 'imap.pooul.cn' #, 993, true, nil, false

    imap.login('qfqpos@pooul.cn', 'caI1111')
    puts 'login suc'

    imap.select('inbox')

    since_time = "30-Nov-2015"

    load_files = Array.new
    imap.search( ["SINCE", since_time ] ).each do |message_id|
      # 判断当前邮件是否是感兴趣的邮件，并做记录
      attachment = imap.fetch(message_id, "BODY[2]")[0].attr["BODY[2]"]

      file_name = "#{path_dir}/#{message_id.to_s}.xls"
      puts file_name

      File.new(file_name,'wb+').write(attachment.unpack('m')[0] )
      load_files << file_name
      #
    end

    # imap.logout
    # imap.close

    load_files
  end


end
