var myjs =function () {
	$('.pagination').addClass('m-t-0 m-b-10');
	$('.pagination span').css('padding','10px');

	$("#weixin").mouseover(function(){
		$('#weixinjy').show();
	})
	$("#weixin").mouseout(function(){
		$('#weixinjy').hide();
	})

	if (window.location.pathname=='/') {
		$('#sidemenu').children().eq(0).addClass('active');
	};
	if (window.location.pathname=='/clients') {
		$('#sidemenu').children().eq(1).addClass('active');
		$('#sidemenu').children().eq(1).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/salesmen') {
		$('#sidemenu').children().eq(1).addClass('active');
		$('#sidemenu').children().eq(1).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/contacts') {
		$('#sidemenu').children().eq(1).addClass('active');
		$('#sidemenu').children().eq(1).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/trades') {
		$('#sidemenu').children().eq(2).addClass('active');
		$('#sidemenu').children().eq(2).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/clearings') {
		$('#sidemenu').children().eq(2).addClass('active');
		$('#sidemenu').children().eq(2).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/imp_logs') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/imp_qf_customers') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/imp_qf_trades') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/imp_qf_clearings') {
		$('#sidemenu').children().eq(3).addClass('active');
		$('#sidemenu').children().eq(3).find('ul li').eq(3).addClass('active');
	};
	if (window.location.pathname=='/users') {
		$('#sidemenu').children().eq(4).addClass('active');
		$('#sidemenu').children().eq(4).find('ul li').eq(0).addClass('active');
	};
	if (window.location.pathname=='/agents') {
		$('#sidemenu').children().eq(4).addClass('active');
		$('#sidemenu').children().eq(4).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/data_manage') {
		$('#sidemenu').children().eq(4).addClass('active');
		$('#sidemenu').children().eq(4).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/addresses') {
		$('#sidemenu').children().eq(5).addClass('active');
		$('#sidemenu').children().eq(5).find('ul li').eq(1).addClass('active');
	};
	if (window.location.pathname=='/pos_machines') {
		$('#sidemenu').children().eq(5).addClass('active');
		$('#sidemenu').children().eq(5).find('ul li').eq(2).addClass('active');
	};
	if (window.location.pathname=='/profile/info') {
		$('#sidemenu').children().eq(6).addClass('active');
		$('#sidemenu').children().eq(6).find('ul li').eq(0).addClass('active');
	};

	$('#beizhubtn').click(function(){
		var checkedradio = $(".radio-inline input[name='optionsRadios']:checked").val();
	 	var bztextval = $('#beizhutext').val();
	 	var mydate = new Date();
		$('#beizhuxinxi').append("<div class='row'><div class='col-md-6'><strong>"+
				checkedradio+"</strong><span>"+bztextval+
				"</span></div><div class='col-md-2'><span>usename</span></div><div class='col-md-2'><span>"
				+mydate+"</span></div><div class='col-md-2'><button class='btn btn-xs btn-default'>归档</button></div></div>");
	});

	$('#biaoqianbtn').click(function(){
		var bqtextval=$('#biaoqiantext').val();
		$('#biaoqianxinxi').append(bqtextval);
		$.ajax({
			type:'GET',
			url:'http://localhost:3000/clients/1/tags?tags='+bqtextval,
			dataType:'json',
			success:function(data){
				alert('ok');
			},
			error: function(jqXHR){
				alert('no');
			}

		});
	});
	$('#cybq button').click(function(){
		var cybqval = $(this).text();
		var dqbqtextval=$('#biaoqiantext').val();
		var newbqtextval=dqbqtextval+cybqval;
		$('#biaoqiantext').val(newbqtextval);
	});
}