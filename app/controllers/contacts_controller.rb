class ContactsController < NestedResourcesController
  def index
    s = params[:s]
    @q = Contact.ransack({'name_cont'=> s,'tel_cont'=> s,'qq_cont'=> s,'roles_cont'=> s, 'm'=> 'or'})
    @collection = @q.result.page( params[:page]).per(100)
  end

end
