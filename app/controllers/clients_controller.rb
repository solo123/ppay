class ClientsController < ResourceController
  # tag管理
  def tags
    load_object
    if request.get?
      @tags = @object.tag_list
    elsif request.post?
      params[:tags].each do |tag|
        @object.tag_list << tag
      end
      @object.save
      redirect_to @object
    else
    end
  end

  # 备注管理
  def note
    load_object
    if request.get?
      @notes = @object.client_notes.page( params[:note_page]).per(5)
    elsif request.post?
      @object.client_notes.create('note'=>params[:note], 'tip'=>params[:tip], 'user'=>current_user)
      redirect_to @object
    else
    end

  end

end
