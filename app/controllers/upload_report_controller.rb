#require "#{Rails.root}/lib/tools/import_mail"

class UploadReportController < ApplicationController
#  include ImportMail

  # layout 'import_data'

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
    puts "Start to import!!"
    #import_from_email
    # 重定向到check path
    ImportDataJob.perform_later nil
    redirect_to imp_logs_path
  end


end
