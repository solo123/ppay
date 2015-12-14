module ApplicationHelper


  def add_left_menu_item(title, options={}, &blk)
    render 'shared/left_menu_item',
              :local => {:title => title,
                          :options => options}

  end

end
