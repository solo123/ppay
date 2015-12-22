module Biz
  class PreProcess

    # process for client table
    def process_client

    #   ImpQfCustomer.all.each do |c|
    #     client = Client.find(shid: c.shid)
    #     if !client
    #       client = Client.create(shid: c.shid, shop_name: c.dm,, rate: c.fl )
    #       client.
    #     end
    #   end
    #   all_shids = ImpQfCustomer.all.group_by{|c| c.shid}
    #   all_shids.each do |shid|
    #     client = Client.new()
    #   end
    end

  end

end
#
#
# t.belongs_to :salesman
#
# t.string :shop_name
# t.string :shop_tel
# t.integer :category_id
# # t.integer :contact_id
# # t.integer :salesman_id
# t.decimal :rate, precision: 12, scale: 6
# t.decimal :bank_card_limit_each, precision: 12, scale: 2
# t.decimal :bank_card_limit_month, precision: 12, scale: 2
# t.decimal :credit_card_limit_each, precision: 12, scale: 2
# t.decimal :credit_card_limit_month, precision: 12, scale: 2
#
#
#
# t.string :shid
# t.string :hylx
# t.string :dm
# t.string :lxr
# t.string :sj
# t.date :rwsj
# t.string :sf
# t.string :cs
# t.text :dz
# t.string :ywy
# t.string :fl
# t.string :zdcm
# t.decimal :jjkdbxe, precision: 12, scale: 2
# t.decimal :jjkdyxe, precision: 12, scale: 2
# t.decimal :xykdbxe, precision: 12, scale: 2
# t.decimal :xykdyxe, precision: 12, scale: 2
# t.integer :imp_log_id
# t.integer :zt
