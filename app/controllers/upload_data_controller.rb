class UploadDataController < ApplicationController
  def import
    puts "Start to import!!"
    ImportDataJob.perform_later nil
    redirect_to imp_logs_path
  end
end
