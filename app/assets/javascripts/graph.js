//= require jquery
//= require jquery_ujs
//= require histogram/histogram
//= require histogram/lib/Tween



$(function(){
	//CHANGE=
	current_poll = 1
	var faye = new Faye.Client('http://'+location.hostname+':9292/faye')
	faye.subscribe("/vote/"+event_id+"/"+poll_id, function(vote) {
		var json_var = jQuery.parseJSON(vote)
		new_data(json_var)
	});
	
	//get canvas
	var canvas = $("canvas#canvas")
	canvas.attr("width", $(window).width())
	canvas.attr("height", $(window).height())
	
	$(window).resize(function() {
		var canvas = $("canvas#canvas")
		canvas.attr("width", $(window).width())
		canvas.attr("height", $(window).height())
		clearTimeout(recalc_timer)
		recalc_timer = setTimeout("reset_display_vars()",500)
	})
	
	
	//graph menus
  $(".graph_menu").animate({opacity: 0}, 3000 );
	$(".graph_menu").hover(function(){
		$(this).animate({opacity: 1}, 200 );	
	}, function() {
		$(this).animate({opacity: 0}, 200 )
	})
	
	$("input#allow_multiple").change(function(){
		var self = $(this)
		$(this).attr("disabled","true")
		var set_to = 0
		if ($(this).is(':checked')) {set_to = 1}
		$.ajax({url: "/events/"+event_id+"/polls/"+poll_id, type: "PUT", data: {multiple: set_to}, success: function(){self.removeAttr("disabled")} })
	})
	
	$("input#receives_votes").change(function(){
		var self = $(this)
		$(this).attr("disabled","true")
		var set_to = 0
		if ($(this).is(':checked')) {set_to = 1}
		$.ajax({url: "/events/"+event_id+"/polls/"+poll_id, type: "PUT", data: {receives_votes: set_to}, success: function(){self.removeAttr("disabled")} })
	})
	
	$("input#show_results").change(function(){
		var self = $(this)
		if ($(this).is(':checked')) {location.reload()}
		else { show = false }
	})
	
	$("input#animate_results").change(function(){
		var self = $(this)
		$(this).attr("disabled","true")
		var set_to = 0
		animation = false
		if ($(this).is(':checked')) {set_to = 1; animation = true}
		$.ajax({url: "/events/"+event_id+"/polls/"+poll_id, type: "PUT", data: {animate_results: set_to}, success: function(){self.removeAttr("disabled")} })
	})
	
	
	
});

