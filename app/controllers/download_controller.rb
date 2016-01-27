class DownloadController < ApplicationController
  def import_xls
    send_file "tmp/qf_xls/#{params[:name]}.#{params[:format]}", type: 'application/vnd.ms-excel', disposition: 'attachment'
  end
end
