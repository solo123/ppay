module ApplicationHelper
  def mydump
    head = "
      <li> nihao </li>
    "
  end

  def add_menu(head, items)
    subs = ''
    items.each do |item|
      sub = "<li><a href=#{item.last}> #{item.first} </a></li>"
      subs += sub
    end

    dump = "
      <li id='trade_li' class='has-sub'>
        <a href='#'>
          <b class='caret pull-right'></b>
          <i class='fa fa-suitcase'></i>
          <span>#{head}</span>
        </a>
        <ul class='sub-menu'>
          #{subs}
        </ul>
      </li>
    "

    return dump
  end
end
