var homejs =function() {
	function month_sum () {
		if ($('#data_monthsum').text().substr(7,1)=='') {
			var month=$('#data_monthsum').text().substr(5,1);
		}else {
			var month=$('#data_monthsum').text().substr(5,2);
		}
		var year=$('#data_monthsum').text().substr(0,4);
		alert(month);
		$.ajax({
			type:'GET',
			url:'http://localhost:3000/activeinfo/month_sum.json?year='+year+'&&month='+month,
			dataType:'json',
			success:function(data){
				var str='';
				for (var i = 0; i < data.length-1; i++) {
					str+="<tr><td>"+(i+1)+"</td><td>"+data[i].amount_sum+"</td><td>"+data[i].num_sum+"</td><td>"+data[i].weichat_amount_sum+"</td><td>"+data[i].weichat_num_sum+"</td><td>"+data[i].alipay_amount_sum+"</td><td>"+data[i].alipay_num_sum+"</td><td>"+data[i].t0_amount_sum+"</td><td>"+data[i].t0_num_sum+"</td></tr>"
				};
				var str_last ="<tr><td>汇总"+"</td><td>"+data[data.length-1].amount_sum+"</td><td>"+data[data.length-1].num_sum+"</td><td>"+data[data.length-1].weichat_amount_sum+"</td><td>"+data[data.length-1].weichat_num_sum+"</td><td>"+data[data.length-1].alipay_amount_sum+"</td><td>"+data[data.length-1].alipay_num_sum+"</td><td>"+data[data.length-1].t0_amount_sum+"</td><td>"+data[data.length-1].t0_num_sum+"</td></tr>"
				$('#monthsum_tbody').html(str+str_last);
			},
		});
	}
	month_sum();
	$('#nextmonth_monthsum').click(function(){
		if ($('#data_monthsum').text().substr(7,1)=='') {
			var b=parseInt($('#data_monthsum').text().substr(5,1))+1;
		}else {
			var b=parseInt($('#data_monthsum').text().substr(5,2))+1;
		}
		$('#data_monthsum').text('2015年'+b+'月');
		month_sum();
	});

	$.ajax({
		type:'GET',
		url:'http://localhost:3000/activeinfo/new_client.json',
		dataType:'json',
		success:function(data){
			var str='';
			for (var i = 0; i < data.length; i++) {
				str+="<tr><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].rate+"</td><td>"+data[i].created_at+"</td><td><a href='#'>详细</a></td></tr>"
			};
			$('#newclient_tbody').append(str);
		},
	});

	$.ajax({
		type:'GET',
		url:'http://localhost:3000/activeinfo/client.json',
		dataType:'json',
		success:function(data){
			var str='';
			for (var i = 0; i < data.length; i++) {
				str+="<tr><td>"+data[i].id+"</td><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].qudao+"</td><td>"+data[i].created_at+"</td><td>"+data[i].rate+"</td></tr>"
			};
			$('#activeclient_tbody').append(str);
		},
	});

	$.ajax({
		type:'GET',
		url:'http://localhost:3000/activeinfo/agent.json',
		dataType:'json',
		success:function(data){
			var str='';
			for (var i = 0; i < data.length; i++) {
				str+="<tr><td>"+data[i].id+"</td><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].qudao+"</td><td>"+data[i].created_at+"</td><td>"+data[i].rate+"</td></tr>"
			};
			$('#activeagent_tbody').append(str);
		},
	});
}