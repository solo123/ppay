module ApplicationHelper


  def add_table_op_menu(title)
    render 'shared/table_op_menu',
              :local => {:title => title}
  end

  def add_left_menu_item(title, options={}, &blk)
    render 'shared/left_menu_item',
              :local => {:title => title,
                          :options => options}

  end

end
