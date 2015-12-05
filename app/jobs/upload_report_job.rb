require 'net/imap'
require 'spreadsheet'


class UploadReportJob < ActiveJob::Base
    queue_as :default

  def perform(*arg)

    imap = Net::IMAP.new 'imap.pooul.cn' #, 993, true, nil, false

    imap.login('qfqpos@pooul.cn', 'caI1111')
    puts 'login suc'

    imap.select('inbox')

    msgs = imap.search( ["SINCE", "30-Nov-2015" ] )

    puts 'select suc'

    # msg = imap.fetch(17, 'BODY[1]' )[0]
    attachment = imap.fetch(17, "BODY[2]")[0].attr["BODY[2]"]

    path = 'public/cc.xls'
    File.new(path,'wb+').write(attachment.unpack('m')[0] )
    #


    book = Spreadsheet.open path

    book.worksheets.each do |sheet|
      sheet.each do |row|
        # do something interesting with a row
        puts row
      end
    end


  end

  def ccperform(file_path)
    logger.warn file_path
    basicAttr = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdh', 'zt']
    tradeAttr = ['ssid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdh', 'zt']
    liquidationdataAttr = ['yhid', 'qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']

    allAttr = [basicAttr, tradeAttr, liquidationdataAttr]

    iAttr = 0
    workbook = RubyXL::Parser.parse(file_path.to_s) # parse_buffer(buffer_path)
    workbook.each { |wksheet|
      wksheet.each { |row|
        puts row

        # cus = getbasicM(iAttr)
        # i = 0
        # for v in allAttr[iAttr] do
        #   puts i, v
        #   theV = (row && row[i] && row[i].value)  || 'no value'
        #   puts theV
        #   cus.send( v + '=', theV)
        #   i += 1
        # end
        # cus.save
      }
      iAttr += 1

    }
  end

  # def getbasicM(type=0)
  #   if type==0
  #     return CustomerBasic.new
  #   elsif type==1
  #     return CustomerTrade.new
  #   elsif type==2
  #     return CustomerLiquidation.new
  #   end
  # end


  around_perform do |job, block|
    logger.warn '开始导入'

    block.call

    logger.warn '结束导入'
  end
end
