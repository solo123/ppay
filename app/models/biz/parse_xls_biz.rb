module Biz
  class ParseXlsBiz
    attr_reader :error_message

    def do_parse_xls(implog)
      @implog = implog
      @error_message = "解析文件出错："
      byebug unless implog.uid
      filename = implog.filename
      return false unless File.exists?(filename)
      begin
        book = Spreadsheet.open filename
        return false unless book

        import_data('imp_qf_customers', book.worksheet(0))
        import_data('imp_qf_trades',    book.worksheet(1))
        import_data('imp_qf_clearings', book.worksheet(2))
        @error_message = nil
        return true
      rescue Exception => e
        @error_message << e.message
        return false
      end
    end
    def do_parse_xlsx(implog)
      @implog = implog
      filename = implog.filename
      return false unless File.exists?(filename)
      book = SimpleXlsxReader.open filename
      return false unless book
      return false unless book.sheets.count > 2

      import_data('imp_qf_customers', book.sheets[0].rows)
      import_data('imp_qf_trades',    book.sheets[1].rows)
      import_data('imp_qf_clearings', book.sheets[2].rows)
      return true
    end

    def get_fields(table_name)
      fields = []
      if table_name == 'imp_qf_customers'
        if @implog.received_at < '2016-01-20'
          fields = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
        else
          fields = ['shid', 'hylx', 'dm', 'lxr', 'sj', 'rwsj', 'sf', 'cs', 'dz', 'ywy', 'shzt', 'fl', 'zdcm', 'jjkdbxe', 'jjkdyxe', 'xykdbxe', 'xykdyxe']
        end
      elsif table_name == 'imp_qf_trades'
        fields = ['shid', 'zzh', 'jyrq', 'jylx', 'jyjg', 'jye', 'zdcm', 'zt']
      elsif table_name == 'imp_qf_clearings'
        fields = ['shid', 'qsrq', 'jybs', 'jybj', 'sxf', 'jsje', 'sjqsje', 'qszt', 'zt']
      end
      fields
    end

    def import_data(table_name, rows)
      fields = get_fields(table_name)
      cnt = 0
      rows.each do |row|
        next if row[1].nil? || row[1].to_i < 1

        cmd = "@implog.#{table_name}.build"
        imp = eval(cmd)
        fields.each_with_index do |field, idx|
          imp[field] = row[idx + 1]
        end
        imp.save
        cnt += 1
      end
      @implog.detail << table_name + ': ' + cnt.to_s + ', '
    end
  end
end
