class DownloadController < ApplicationController
  def import_xls
    send_file "tmp/#{params[:name]}.xls"
  end
end
