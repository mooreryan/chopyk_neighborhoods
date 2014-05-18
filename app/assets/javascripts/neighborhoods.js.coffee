# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

drawRead = (paper, read_len, read_name, elem_width, elem_height) ->
	svg_width = elem_width
	svg_height = elem_height
	pad = 100
	rect_width = svg_width - pad
	rect_height = 8
	read_start = 1
	read_stop = read_len
	rect_start = pad / 2
	rect_stop = rect_start + rect_width - 1
	scaling_factor = rect_width / read_len
	rect_y = svg_height / 3
	
	r = paper.rect(x=rect_start, y=rect_y, width=rect_width, height=rect_height)

	tick_x_vals = (n for n in [rect_start..rect_stop] by (read_len / 10 * scaling_factor))
	paper.rect(x=n, y=rect_y, width=2, height=15) for n in tick_x_vals

	tick_labels = (n for n in [read_start..read_stop+(read_len / 10)] by Math.round(read_len / 10))
	paper.text(x=n+3, y=rect_y+20, text=tick_labels[idx]) for n, idx in tick_x_vals
	paper.text(x=rect_start+10, y=rect_y-5, read_name)

	return scaling_factor

drawGene = (paper, gene_len, gene_start, scaling_factor, gene_name, color, elem_height) ->
	svg_height = elem_height
	pad = 100
	rect_width = gene_len * scaling_factor
	rect_height = 25
	gene_stop = gene_len
	rect_start = (pad / 2) + (gene_start * scaling_factor)
	rect_y = 2 * svg_height / 3

	g = paper.rect(x=rect_start, y=rect_y, width=rect_width, height=rect_height, rx=10)
	t = paper.text(x=rect_start+10, y=rect_y-5, gene_name)

	g.attr
		fill: color

	t.attr
		fill: color

# not great as it depends on the order the genes are drawn
getColor = (idx) ->

	colors = ["Aqua", "Aquamarine", "BlueViolet", "Brown", "Coral", "Cyan", "DarkOrange"]

	if idx > colors.length-1
		console.error(idx)
		console.error("black")
		return "black"
	else
		console.error(idx)
		console.error(colors[idx])
		return colors[idx]

foobar = (paper, contig, contigLength, orfInfo, elem_width, elem_height) ->
	scaling_factor = drawRead(paper, read_len=contigLength, read_name=contig, elem_width=elem_width, elem_height=elem_height)
	(drawGene(paper, gene_len=orf[2], gene_start=orf[1], scaling_factor, gene_name=orf[0], getColor(idx), elem_height) for orf, idx in orfInfo)

$ ->
	svgElements =	(document.getElementById(contig) for contig in gon.contigs)
	papers = (Snap(svgElement) for svgElement in svgElements)
	(foobar(paper, gon.contigs[idx], gon.lengths[idx], gon.orfs[idx], svgElements[0].width.animVal.value, svgElements[0].height.animVal.value) for paper, idx in papers)

