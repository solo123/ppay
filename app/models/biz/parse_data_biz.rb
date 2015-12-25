module Biz
  class ParseDataBiz
    def parseCustomers
      slog('0. 开始解析数据...')
      ImpQfCustomer.new_data.each do |c|
        parseCustomer(c)
      end
      slog('import_end')
    end
    def parseCustomer(c)
      return if c.zt && c.zt > 0
      if c.shid.empty?
        c.zt = 7
        c.save
      else
        client = Client.find_or_create_by(shid: c.shid)
        client.shop_name = c.dm
        client.shop_tel = c.sj
        client.rate = c.fl
        client.bank_card_limit_each = c.jjkdbxe
        client.bank_card_limit_month = c.jjkdyxe
        client.credit_card_limit_each = c.xykdbxe
        client.credit_card_limit_month = c.xykdyxe
        client.category = CodeTable.find_code(:biz_catalog, c.hylx)
        if client.changed?
          client.save
          slog("更新资料：id:#{client.shid} - #{client.shop_name}")
        end
        dz = client.addresses
        unless dz.count > 0
          prov = CodeTable.find_prov(c.sf)
          city = CodeTable.find_city(prov.id, c.cs)
          dz = client.addresses.create(province_id: prov.id, city_id: city.id, street: c.dz )
          dz.save
          slog("新增地址：[#{dz.id}] #{c.sf}, #{c.cs}, #{c.dz}")
        end
        if c.lxr.nil? || c.lxr.empty?
        else
          lxr = Contact.find_or_create_by(name: c.lxr, tel: c.sj)
          client.contacts << lxr
        end
        if c.ywy.nil? || c.ywy.empty?
          client.salesman = Salesman.find_or_create_by(name: 'pooul')
        else
          client.salesman = Salesman.find_or_create_by(name: c.ywy)
        end
        unless c.zdcm.nil? || c.zdcm.empty?
          pos = PosMachine.find_or_create_by(serial_number: c.zdcm)
          pos.join_date = c.rwsj
          client.pos_machines << pos
        end
        client.save
        c.zt = 1
        c.save
      end
    end
    def slog(msg)
      puts msg
      $redis.lpush(:parse_log, msg)
    end
  end
end
