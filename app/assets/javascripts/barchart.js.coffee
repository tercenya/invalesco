# larged based on
# @see http://bost.ocks.org/mike/bar/3/

# useful references
# @see https://github.com/mbostock/d3/wiki/Ordinal-Scales
# @see https://github.com/mbostock/d3/wiki/Quantitative-Scales

margin =
  top: 20
  right: 30
  bottom: 30
  left: 50

width = 960 - margin.left - margin.right
height = 500 - margin.top - margin.bottom
padding = 0.25

xordinal = d3.scale.ordinal()
  .rangeRoundBands([ 0, width ], padding)

xlinear = d3.scale.linear()

y = d3.scale.linear()
  .rangeRound([ height, 0 ])

xAxis = d3.svg.axis()
  .scale(xlinear)
  .orient('bottom')

yAxis = d3.svg.axis()
  .scale(y)
  .orient('left')

@drawOrdinalLinearBarchart = (target, payload) ->
  node = $(target)
  chart = d3.select(target)
    .append('svg')
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

  data = $.map payload, (k,v) -> { key: parseInt(v), value: parseInt(k) }

  xordinal.domain(data.map (d) -> d.key )

  xAxis.ticks(data.length).tickFormat((d) -> d + '%')
  xlinear
    # account for the differences in rangeRoundBands
    .rangeRound([ 0 + xordinal.rangeBand()*padding, width - xordinal.rangeBand()*padding ])
    # create a continous linear domain
    .domain([d3.min(data, (d) -> d.key), d3.max(data, (d) -> d.key) + 1])

  y.domain([0, d3.max(data, (d) -> d.value )])

  console.log y.domain()

  color = d3.scale.ordinal()
    .domain([0,1,2])
    .range(['high', 'med', 'low'])

  chart.append('g')
    .attr('class', 'x axis')
    .attr('transform', 'translate(0,' + height + ')')
    .call xAxis

  chart.append('g')
    .attr('class', 'y axis')
    .call yAxis

  chart.selectAll('.bar')
    .data(data)
    .enter().append('rect')
      .classed('bar', true)
      .attr('x', (d) -> xordinal(d.key) )
      .attr('y', (d) -> y(d.value) )
      .attr('height', (d) -> height - y(d.value) )
      .attr('width', xordinal.rangeBand())


@drawOrdinalBarchart = (target, payload) ->
  node = $(target)
  chart = d3.select(target)
    .append('svg')
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

  data = $.map payload, (k,v) -> { key: parseInt(v), value: parseInt(k) }


  xordinal.domain(data.map (d) -> d.key )
  xAxis.scale(xordinal)

  y.domain([0, d3.max(data, (d) -> d.value )])

  console.log y.domain()

  color = d3.scale.ordinal()
    .domain([0,1,2])
    .range(['high', 'med', 'low'])

  chart.append('g')
    .attr('class', 'x axis')
    .attr('transform', 'translate(0,' + height + ')')
    .call xAxis

  chart.append('g')
    .attr('class', 'y axis')
    .call yAxis

  chart.selectAll('.bar')
    .data(data)
    .enter().append('rect')
      .classed('bar', true)
      .attr('x', (d) -> xordinal(d.key) )
      .attr('y', (d) -> y(d.value) )
      .attr('height', (d) -> height - y(d.value) )
      .attr('width', xordinal.rangeBand())

@drawLinearBarchart = (target, payload) ->
  node = $(target)
  chart = d3.select(target)
    .append('svg')
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

  data = $.map payload, (k,v) -> { key: parseInt(v), value: parseInt(k) }

  xlinear
    .rangeRound([ 0, width])
    .domain([d3.min(data, (d) -> d.key), d3.max(data, (d) -> d.key) + 1])

  y.domain([0, d3.max(data, (d) -> d.value )])

  console.log y.domain()

  color = d3.scale.ordinal()
    .domain([0,1,2])
    .range(['high', 'med', 'low'])

  chart.append('g')
    .attr('class', 'x axis')
    .attr('transform', 'translate(0,' + height + ')')
    .call xAxis

  chart.append('g')
    .attr('class', 'y axis')
    .call yAxis

  chart.selectAll('.bar')
    .data(data)
    .enter().append('rect')
      .classed('bar', true)
      .attr('x', (d) -> xlinear(d.key) )
      .attr('y', (d) -> y(d.value) )
      .attr('height', (d) -> height - y(d.value) )
      .attr('width', width / data.length - 1)
