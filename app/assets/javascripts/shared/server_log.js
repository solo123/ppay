function load_status(){
  $.get('logs/get_log_msg?log_name=server_log', function(data){
    if (data){
      msgs = data.split('|');
      var d = $('#dialog_messages');
      if(d != null){
        $.each(msgs, function(index, value){
          if (value && value.substring(0,1)==':'){
            if (value.substring(1,2) == '%'){
              s = value.split(' ');
              if (s.length>3){
                if ($('#' + s[1]).length==0){
                  $('#dialog_messages')
                    .append('<div id="'+ s[1] +'" class="progress progress-striped progress-sm active m-t-5"><div class="progress-bar progress-bar-success" style="width: 40%">40%</div></div>');
                }
                $('#' + s[1] + ' div')
                  .attr('style','width: '+ s[3]/s[2]*100 +'%')
                  .text(s[3] + ' / ' + s[2]);
              }
            } else {
              var idx = value.indexOf(' ');
              var tag = value.substr(1, idx-1);
              $('#dialog_messages').append($('<'+tag+'>').append(value.substr(idx+1)));
            }
          } else {
            $('#dialog_messages').append('<p>' + value + '</p>');
          }
          if (value.indexOf('[job_end]')>=0) {
            clearInterval(my_process);
          }
        });
        d = d.get(0);
        d.scrollTop = d.scrollHeight;
      }
    }
  });
}
