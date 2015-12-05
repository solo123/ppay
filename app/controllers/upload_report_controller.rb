require "#{Rails.root}/lib/tools/import_mail"


class UploadReportController < ApplicationController
  include ImportMail

  def check
    @q = ImpQfCustomer.ransack(params[:q])
    @imp_cus = @q.result(distinct: true).page params[:page]

    @imp_trade = ImpQfTrade.page params[:page]

    @imp_log = ImpLog.page params[:page]
  end

  def upload
    download_email
  end

end
