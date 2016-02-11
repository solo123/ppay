class AdminController < ApplicationController
  before_action :authenticate_user!
  after_filter :log_operation

  def log_operation
    return if defined?(@no_log) && @no_log == 1
    log = Log.new
    log.user = current_user
    log.page_url = request.headers['PATH_INFO']
    log.host = request.headers['SERVER_NAME']
    log.remote_addr = request.headers['REMOTE_ADDR']
    log.remote_host = request.headers['REMOTE_HOST']
    log.controller = controller_name
    log.action = action_name
    log.log_title = @log_title if defined? @log_title
    log.log_detail = @log_detail if defined? @log_detail
    log.level = 0
    if action_name == 'index'
      log.log_title ||= 'list ' + log.controller
      log.level = 1
    elsif action_name == 'show'
      log.log_title ||= 'view ' + log.controller + ':' + params[:id]
      log.level = 1
    elsif action_name == 'new' || action_name == 'edit'
      log.level = 0
    elsif action_name == 'create'
      log.log_title ||= 'add new ' + log.controller
      log.ref_data = @object if defined? @object
      log.level = 3
    elsif action_name == 'update'
      log.log_title ||= 'edit ' + log.controller + ': ' + params[:id]
      if !log.log_detail && (defined? @object) && (defined? @changes) && @changes && @changes.length > 0
        log.log_detail = @changes.length.to_s + ' changes maked: ' + @changes.to_s
        log.ref_data = @object
        log.level = 3
      else
        log.level = 0
      end
    elsif action_name == 'destroy'
      log.log_title ||= 'hide/del ' + log.controller + ': ' + params[:id]
      log.log_detail ||= params.to_s
      log.ref_data = @object if defined? @object
      log.level = 4
    else
      log.log_title ||= "#{log.action} #{log.controller}: #{params[:id]}"
      log.log_detail ||= params.to_s
      if defined? @log_level
        log.level = @log_level
      else
        log.level = 2
      end
    end
    log.save if log.level > 0
    log
  end

  def log_detail(title, detail, parent)
    log = Log.new
    log.parent = parent
    log.user = current_user
    log.log_title = title
    log.log_detail = detail
    log.level = 2
    log.save
  end

end
