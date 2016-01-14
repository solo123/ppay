//初始化日期和数据
$(document).ready(function(){
	var nowdate= new Date();
	var month=nowdate.getMonth()+1;
	var year=nowdate.getFullYear();
	$('#date_monthsum').text(year+'-'+('0'+month).substr(-2,2));
	$('#date_activeclient').text(year+'-'+('0'+month).substr(-2,2));
	$('#date_activeagent').text(year+'-'+('0'+month).substr(-2,2));
	$('#month_client_day_tradetotals_path').attr('href','/client_day_tradetotals/month?year='+year+'&month='+month);
	$('#active_client_day_tradetotals_path').attr('href','/client_day_tradetotals/active?year='+year+'&month='+month);
	$('#agent_day_tradetotals_btn').attr('href','/agent_day_tradetotals?year='+year+'&month='+month);
	$('#joinlast_clients_index_path').attr('href','/joinlast_clients');
	$('#month_client_day_tradetotals_path').trigger("click");
	$('#active_client_day_tradetotals_path').trigger("click");
	$('#agent_day_tradetotals_btn').trigger("click");
	$('#joinlast_clients_index_path').trigger("click");
});

var homejs=function(){
	// 分页button 
	$('#nextmonth_monthsum').click(function(){
		var month=parseInt($('#date_monthsum').text().substr(-2,2));
		var year=parseInt($('#date_monthsum').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		$('#date_monthsum').text(year+'-'+('0'+month).substr(-2,2));
		$('#month_client_day_tradetotals_path').attr('href','/client_day_tradetotals/month?year='+year+'&month='+month);
		$('#month_client_day_tradetotals_path').trigger("click");
	});
	$('#premonth_monthsum').click(function(){
		var month=parseInt($('#date_monthsum').text().substr(-2,2));
		var year=parseInt($('#date_monthsum').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		$('#date_monthsum').text(year+'-'+('0'+month).substr(-2,2));
		$('#month_client_day_tradetotals_path').attr('href','/client_day_tradetotals/month?year='+year+'&month='+month);
		$('#month_client_day_tradetotals_path').trigger("click");
	});

	$('#nextmonth_activeclient').click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		$('#date_activeclient').text(year+'-'+('0'+month).substr(-2,2));
		$('#active_client_day_tradetotals_path').attr('href','/client_day_tradetotals/active?year='+year+'&month='+month);
		$('#active_client_day_tradetotals_path').trigger("click");
	});
	$('#premonth_activeclient').click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		$('#date_activeclient').text(year+'-'+('0'+month).substr(-2,2));
		$('#active_client_day_tradetotals_path').attr('href','/client_day_tradetotals/active?year='+year+'&month='+month);
		$('#active_client_day_tradetotals_path').trigger("click");
	});

	$('#nextmonth_activeagent').click(function(){
		var month=parseInt($('#date_activeagent').text().substr(-2,2));
		var year=parseInt($('#date_activeagent').text().substr(0,4));
		if (month==12) {month=1;year+=1;}else {month+=1;}
		$('#date_activeagent').text(year+'-'+('0'+month).substr(-2,2));
		$('#agent_day_tradetotals_btn').attr('href','/agent_day_tradetotals?year='+year+'&month='+month);
		$('#agent_day_tradetotals_btn').trigger("click");
	});
	$('#premonth_activeagent').click(function(){
		var month=parseInt($('#date_activeagent').text().substr(-2,2));
		var year=parseInt($('#date_activeagent').text().substr(0,4));
		if (month==1) {year-=1;month=12;}else{month-=1;};
		$('#date_activeagent').text(year+'-'+('0'+month).substr(-2,2));
		$('#agent_day_tradetotals_btn').attr('href','/agent_day_tradetotals?year='+year+'&month='+month);
		$('#agent_day_tradetotals_btn').trigger("click");
	});
//  商户以及代理商的排序button
	$('#orderbtn-client').children().click(function(){
		var month=parseInt($('#date_activeclient').text().substr(-2,2));
		var year=parseInt($('#date_activeclient').text().substr(0,4));
		$('#active_client_day_tradetotals_path').attr('href','/client_day_tradetotals/active?year='+year+'&month='+month+'&order='+$(this).attr('value'));
		$('#active_client_day_tradetotals_path').trigger("click");
	});
	$('#orderbtn-agent').children().click(function(){
		var month=parseInt($('#date_activeagent').text().substr(-2,2));
		var year=parseInt($('#date_activeagent').text().substr(0,4));
		$('#agent_day_tradetotals_btn').attr('href','/agent_day_tradetotals?year='+year+'&month='+month+'&order='+$(this).attr('value'));
		$('#agent_day_tradetotals_btn').trigger("click");
	});
}
