var homejs =function() {
	$.ajax({
		type:'GET',
		url:'http://localhost:3000/123.text',
		dataType:'text',
		success:function(data){
			$('#wxl').append(data);
		},
	})
}