//= require jquery
//= require jquery_ujs
//= require_self
//= require faye-browser-min

$(function(){
	
	//Listen for press
	$(".vote_button").click(function(){
		var button = $(this)
		
		$.rails.ajax({
			url: button.attr("href")+"&ajax=1",
			success: function(data)	{	
																if (data == "OK") {
																	$(".vote_button").removeClass("checked")
																	button.addClass("checked")
																}
															}
		});		
		
		return false;
		
	})
	
	
	//CHANGE=
	var faye = new Faye.Client('http://'+location.hostname+':9292/faye')
	faye.subscribe("/button/"+event_id, function(data) {
		var json_var = jQuery.parseJSON(data)
		

		
		
		update_view(json_var)
		console.log(json_var)
		
	});
	

	update_view = function(data) {
		$(".vote_button").removeClass("checked")
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
