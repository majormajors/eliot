context = cubism.context()
                .serverDelay(10000)
                .step(1000)
                .size(700)

window.context = ->
  context

addMetric = (e) ->
  $this =$ this
  aggregator = $this.find('select#aggregator').val()
  metric = $this.find('select#metric').val()
  scale = parseInt($this.find('input#scale').val())
  query = aggregator + ':' + metric

  d3.select('#ts-graph').call (graph) ->
    div = graph.append('div')
               .attr('class', 'horizon')
               .attr('data-metric-query', query)
               .attr('data-metric-scale', scale)
    loadMetric(div)

  return false

loadMetric = (div) ->
  query = div.attr('data-metric-query')
  scale = div.attr('data-metric-scale')
  url = div.attr('data-server-url')

  if typeof scale == 'undefined' || scale == 0
    scale = 100

  tsdb = window.server(url)
  metric = tsdb.metric(query)
  horizon = context.horizon()
    .metric(metric)
    .title(query)
    .extent([0, scale])
    .height(100)
  div.call(horizon)

$ ->
  $graph =$ '#ts-graph'

  $('.add-metric').bind('submit', addMetric)

  d3.select('#ts-graph').call (holder) ->
    holder.select('.axis').call(context.axis().orient('top'))
    holder.append('div').attr('class','rule').call(context.rule())
    holder.selectAll('.horizon').each ->
      loadMetric(this)
