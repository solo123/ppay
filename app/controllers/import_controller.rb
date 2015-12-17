class ImportController < ApplicationController
  def do_import
    $redis.lpush :import_log, "Import begin............."
    ImportDataJob.perform_later nil
  end

  def get_import_msg
    r = ""
    while (msg = $redis.rpop(:import_log))
      r << "<p>#{msg}</p>"
    end
    render :text =>  r.html_safe
  end
end
