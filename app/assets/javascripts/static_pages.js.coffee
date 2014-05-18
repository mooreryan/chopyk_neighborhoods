# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# this always runs even before i call it!
# foo = (circ, text) ->
# 	circ.animate({cx: 200, cy: 200, r: 200}, 1000)
# 	text.animate({x: 200, y: 200}, 1000)
#
#

# bar = (circ, text) ->
# 	circ.animate({cx: 150, cy: 150, r: 150}, 1000)
# 	text.animate({x: 150, y: 150}, 1000)

# drawRead = (paper, read_len, read_name) ->
# 	svg_width = document.getElementById('apple').offsetWidth
# 	svg_height = document.getElementById('apple').offsetHeight
# 	pad = 100
# 	rect_width = svg_width - pad
# 	rect_height = 8
# 	read_start = 1
# 	read_stop = read_len
# 	rect_start = pad / 2
# 	rect_stop = rect_start + rect_width - 1
# 	scaling_factor = rect_width / read_len
# 	rect_y = svg_height / 3
	
# 	r = paper.rect(x=rect_start, y=rect_y, width=rect_width, height=rect_height)

# 	tick_x_vals = (n for n in [rect_start..rect_stop] by (read_len / 10 * scaling_factor))
# 	paper.rect(x=n, y=rect_y, width=2, height=15) for n in tick_x_vals

# 	tick_labels = (n for n in [read_start..read_stop+(read_len / 10)] by Math.round(read_len / 10))
# 	paper.text(x=n+3, y=rect_y+20, text=tick_labels[idx]) for n, idx in tick_x_vals
# 	paper.text(x=rect_start+10, y=rect_y-5, read_name)

# 	return scaling_factor

# drawGene = (paper, gene_len, gene_start, scaling_factor, gene_name, color) ->
# 	svg_height = document.getElementById('apple').offsetHeight
# 	pad = 100
# 	rect_width = gene_len * scaling_factor
# 	rect_height = 25
# 	gene_stop = gene_len
# 	rect_start = (pad / 2) + (gene_start * scaling_factor)
# 	rect_y = 2 * svg_height / 3

# 	g = paper.rect(x=rect_start, y=rect_y, width=rect_width, height=rect_height, rx=5)
# 	t = paper.text(x=rect_start+10, y=rect_y-5, gene_name)

# 	g.attr
# 		fill: color

# 	t.attr
# 		fill: color

# $ ->
# 	svgElement = document.getElementById("apple")
# 	console.error(svgElement)
# 	paper = Snap(svgElement)
# 	# circ = paper.circle(gon.posns[0], gon.posns[1], gon.posns[2])
# 	# circ.attr
#   #   fill: "#bada55"
#   #   stroke: "#000"
#   #   strokeWidth: 5
# 	# myText = paper.text(gon.posns[0], gon.posns[1], "Foobar")
# 	# myGroup = paper.group(circ, myText)
# 	# myGroup.drag()
# 	# myGroup.click(-> foo(circ, myText))
# 	# rect = paper.rect(x=340, y=340, width=100, height=50, rx=10)
# 	# rect.drag()
# 	scaling_factor = drawRead(paper, read_len=2500, read_name="contig22345")
# 	drawGene(paper, gene_len=738, gene_start=200, scaling_factor, gene_name="ryanase", "blue")
# 	drawGene(paper, gene_len=523, gene_start=1009, scaling_factor, gene_name="danase", "green")
