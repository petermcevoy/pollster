root = exports ? this

canvas = ""
ctx = ""
root.squares = []
root.show = true
root.animation = true


square_size = 25
column_width = 1
root.recalc_timer = null
columns_in_use = 0
dynamic_columns = true
letters = null

#internal vars
columns = {"a": {n_squares: 0, used: false},"b": {n_squares: 0, used: false},"c": {n_squares: 0, used: false},"d": {n_squares: 0, used: false}}
alpha = ["a","b","c","d"]
root.data_index = {}

increment_columns = ->
	columns_in_use++

root.start_histogram = (canvas_element, data) ->
	canvas = canvas_element
	ctx = canvas.getContext("2d")
	
	#check defaults
	if colors.length == 0
		root.colors = {"a": "#333333", "b": "#123456", "c": "#81A18A", "d": "#A19191"}
		
	if dynamic_columns == true
		columns_in_use = 0
	
	#set letter
	
	letters = {"a": new Letter("a"),"b": new Letter("b"),"c": new Letter("c"),"d": new Letter("d")}
	
	for obj in data
		do (obj) ->
			s = new Square(obj.value,obj.id,false)
			squares.push(s)
			data_index["id_"+obj.id] = s
	recalc_squares()
	
	setInterval( ->
		render()
	,25)

root.clear_histogram = ->
	root.squares = []
	root.data_index = {}
	recalc_squares()
	

render = ->
	ctx.clearRect(0,0,canvas.width,canvas.height)
	if root.show == true
		TWEEN.update();
		for square in squares
			do (square) ->
				ctx.fillStyle = colors[square.value]
				tmp_position = square.position if root.animation == true
				tmp_position = square.target_position if root.animation == false
				ctx.fillRect(tmp_position.x + 5,canvas.height-100-tmp_position.y,square_size,square_size)

		#´labels
		ctx.font = "bold 18px sans-serif";
		for i of letters
			if columns[i].n_squares != 0
				ctx.fillStyle = colors[i]
				ctx.fillText(letters[i].value.toUpperCase(), letters[i].position.x, canvas.height-40);
		
	ctx.font = "normal 18px sans-serif";
	ctx.fillStyle = root.colors["a"];
	vote_str = if squares.length == 1 then "response." else "responses."
	ctx.fillText(squares.length+" "+vote_str,8,canvas.height-10);
	
	



root.new_data = (data) ->
	#recives data like this {value: "a", id: "session_id", "multiple": true/false}
	
	#make new or update?
	if data["multiple"]
		s = new Square(data.value,data.id)
		squares.push(s)
		data_index["id_"+data.id] = s
	else
		if typeof data_index["id_"+data.id] == "undefined"
			s = new Square(data.value,data.id)
			squares.push(s)
			data_index["id_"+data.id] = s
		else
			data_index["id_"+data.id].value = data.value

	
	clearTimeout(root.recalc_timer)
	root.recalc_timer = setTimeout("recalc_squares()",3000)

root.recalc_squares = ->
	cahnge = 0
	
	#column resizing
	largest = 
		  key: null
		  val: null

	for i of columns
		if columns[i].n_squares > largest.val
			largest.key = i
			largest.val = columns[i].n_squares
	
	px_high = (Math.floor(columns[largest.key].n_squares/column_width))*(square_size+5) unless largest.key == null
		
	if (px_high > canvas.height-120)
		if column_width < 8
			column_width++
			change = 1
			recalc_squares()
		else if square_size > 5
			square_size--
			change = 1
			recalc_squares()
	else	
		# Square positioning
	
		columns.a.n_squares = 0
		columns.b.n_squares = 0
		columns.c.n_squares = 0
		columns.d.n_squares = 0
		for square in squares
			do (square) -> 
				square.set_pos()
		
		#letter positioning
		for i of letters
			letters[i].set_pos() if columns[i].n_squares != 0
	
root.reset_display_vars = ->
	square_size = 25
	column_width = 1 
	recalc_squares()


class Letter
	constructor: (value) ->
		@value = value
		@position = {x:canvas.width/2}
		
	set_pos: ->
		start_x = canvas.width/2 - (((square_size+5)*column_width+(square_size+5))*columns_in_use)/2
		tmp_x = start_x + alpha.indexOf(@value)*(column_width*(square_size+5)+(square_size+5)) + column_width*(square_size+5)/2
		@target_position = {x:tmp_x}
		@tween = new TWEEN.Tween(@position)
								.to({ x: @target_position.x }, 2000)
								.delay(Math.random() * 1000)
								.easing(TWEEN.Easing.Exponential.EaseInOut)
								.start();
		

class Square	
	constructor: (value,id,set_pos=true) ->
		@value = value
		@id = id
		@position = {x: canvas.width/2, y: canvas.height}
		
		if set_pos == false
			columns[@value].n_squares++
			if (columns[@value].used == false && dynamic_columns == true && columns_in_use <= 3)
				columns[@value].used = true
				if (@value == "d")
					columns_in_use=3
				columns_in_use++
		this.set_pos() if set_pos
		
	set_pos: ->
		# set target position
		# Get squares in column
		 
		## get start offset 
		#columns in use (1)
		if (columns[@value].used == false && dynamic_columns == true && columns_in_use <= 3)
			columns[@value].used = true
			if (@value == "d")
				columns_in_use=3
			columns_in_use++
			clearTimeout(root.recalc_timer)
			root.recalc_timer = setTimeout("recalc_squares()", 3000);
		
		start_x = canvas.width/2 - (((square_size+5)*column_width+(square_size+5))*columns_in_use)/2
		
		offset = column_width*(square_size+5)*alpha.indexOf(@value) + start_x
		if(@value != "a")
			offset = offset + (square_size+5)*alpha.indexOf(@value)
			
		tmp_x = columns[@value].n_squares*(square_size+5)-(Math.floor(columns[@value].n_squares/column_width)*column_width)*(square_size+5) 
		tmp_y = (Math.floor(columns[@value].n_squares/column_width))*(square_size+5)
		@target_position = {x: tmp_x + offset, y: tmp_y}
		@tween = new TWEEN.Tween(@position)
								.to({ x: @target_position.x, y: @target_position.y }, 2000)
								.delay(Math.random() * 1000)
								.easing(TWEEN.Easing.Exponential.EaseInOut)
								.start();
		columns[@value].n_squares++
		
		
