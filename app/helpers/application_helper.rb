module ApplicationHelper

  def simple_menu(title, options={}, &blk)
    subs = ''
    if options[:data]
      options[:data].each do |item|
        sub = "<li><a href=#{item.last}> #{item.first} </a></li>"
        subs += sub
      end

    end

    dump = "
      <li id='trade_li' class='has-sub'>
        <a href='#'>
          <b class='caret pull-right'></b>
          <i class='fa #{options[:class]}'></i>
          <span>#{title}</span>
        </a>
        
        <ul class='sub-menu'>
          #{subs}
        </ul>
      </li>
    "

    return dump
  end
end
