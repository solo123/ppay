var homejs =function() {
	function month_sum () {
		var date_text=$('#date_monthsum').text();
		var mydate=new Date(Date.parse(date_text));
		var year=mydate.getFullYear();
		var month=mydate.getMonth()+1;
		$.ajax({
			type:'GET',
			url:'/activeinfo/month_sum.json?year='+year+'&month='+month+'&random=' + Math.random(),
			dataType:'json',
			success:function(data){
				var str='';
				for (var i = 0; i < data.length; i++) {
					if (data[i]==null) {
						str+="<tr><td>"+(i+1)+"</td><td>"+0+"</td><td>"+0+"</td><td>"+0+"</td><td>"+0+"</td><td>"+0+"</td><td>"+0+"</td><td>"+0+"</td><td>"+0+"</td></tr>";
					}else{
						str+="<tr><td>"+(i+1)+"</td><td>"+data[i].total_amount+"</td><td>"+data[i].total_count+"</td><td>"+data[i].weichat_amount+"</td><td>"+data[i].weichat_count+"</td><td>"+data[i].alipay_amount+"</td><td>"+data[i].alipay_count+"</td><td>"+data[i].t0_amount+"</td><td>"+data[i].t0_count+"</td></tr>";
					}
				}
				// alert(str);
				// str +="<tr><td>汇总"+"</td><td>"+data[data.length-1].total_amount+"</td><td>"+data[data.length-1].total_count+"</td><td>"+data[data.length-1].weichat_amount+"</td><td>"+data[data.length-1].weichat_count+"</td><td>"+data[data.length-1].alipay_amount+"</td><td>"+data[data.length-1].alipay_count+"</td><td>"+data[data.length-1].t0_amount+"</td><td>"+data[data.length-1].t0_count+"</td></tr>";
				$('#monthsum_tbody').html(str);
			},
		});
	}
	month_sum();
	$('#nextmonth_monthsum').click(function(){
		var month=parseInt($('#date_monthsum').text().substr(-2,2));
		var year=parseInt($('#date_monthsum').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		a='0'+month;
		// alert(a.substr(-2,2));
		$('#date_monthsum').text(year+'-'+a.substr(-2,2));
		// alert($('#date_monthsum').text());
		month_sum();
	});
	$('#premonth_monthsum').click(function(){
		var month=parseInt($('#date_monthsum').text().substr(-2,2));
		var year=parseInt($('#date_monthsum').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		a='0'+month;
		$('#date_monthsum').text(year+'-'+a.substr(-2,2));
		month_sum();
	});

	$.ajax({
		type:'GET',
		url:'http:/activeinfo/new_client.json',
		dataType:'json',
		success:function(data){
			var str='';
			for (var i = 0; i < data.length; i++) {
				str+="<tr><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].rate+"</td><td>"+data[i].created_at+"</td><td><a href='#'>详细</a></td></tr>"
			};
			$('#newclient_tbody').append(str);
		},
	});


	function active_client () {
		var date_text=$('#date_activeclient').text();
		var mydate=new Date(Date.parse(date_text));
		var year=mydate.getFullYear();
		var month=mydate.getMonth();
		$.ajax({
			type:'GET',
			// url:'http:/activeinfo/client.json?year='+year+'&&month='+month,
			url:'http://root.com/activeinfo/client.json?year=2015&month=11&order=total_count',
			dataType:'json',
			success:function(data){
				var str='';
				for (var i = 0; i < data.length; i++) {
					str+="<tr><td>"+data[i].id+"</td><td>"+data[i].shop_name+"</td><td>"+data[i].shid+"</td><td>"+data[i].shop_tel+"</td><td>"+data[i].category_id+"</td><td>"+data[i].salesman_id+"</td><td>"+data[i].qudao+"</td><td>"+data[i].created_at+"</td><td>"+data[i].rate+"</td></tr>"
				};
				$('#activeclient_tbody').html(str);
			},
		});
	}
	active_client();
	$('#nextmonth_activeclient').click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		a='0'+month;
		// alert(a.substr(-2,2));
		$('#date_activeclient').text(year+'-'+a.substr(-2,2));
		active_client();
	});
	$('#premonth_activeclient').click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		a='0'+month;
		$('#date_activeclient').text(year+'-'+a.substr(-2,2));
		active_client();
	});



	$.ajax({
		type:'GET',
		url:'http:/activeinfo/agent.json',
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
