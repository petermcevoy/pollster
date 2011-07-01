//= require jquery
//= require jquery_ujs

$(function(){
	

	
	//CHANGE=
	var faye = new Faye.Client('http://192.168.1.202:9292/faye')
	faye.subscribe("/button/"+event_id, function(data) {
		var json_var = jQuery.parseJSON(data)
		

		
		
		update_view(json_var)
		
		console.log(json_var)
		
	});
	

	update_view = function(data) {
		$("h1").text("Poll #"+data["poll_id"])

		console.log(parseInt(data["options"]))

		if (parseInt(data["options"]) >= 3) 	{ $(".c").show() }
			else 																{ $(".c").hide() }

		if(parseInt(data["options"]) >= 4) 		{ $("a.d").show() }
			else 																{ $("a.d").hide() }

	}
	
	
		update_view(info)
	
		
});





$(function(){
//	$("a.vote_button").click(function(){
		var value = $(this).attr("value")
	//	alert(value)
	//	return false
//	})
})
