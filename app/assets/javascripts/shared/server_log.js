var current_log_name = '';
function load_status(){
  $.get('logs/get_log_msg?log_name=' + current_log_name, function(data){
    if (data){
      msgs = data.split('|');
      var d = $('#dialog_messages');
      if(d != null){
        $.each(msgs, function(index, value){
          d.append('<p>' + value + '</p>');
          if (value.indexOf('import_end')>=0) {
            clearInterval(my_process);
          }
        });
        d = d.get(0);
        d.scrollTop = d.scrollHeight;
      }
    }
  });
}
