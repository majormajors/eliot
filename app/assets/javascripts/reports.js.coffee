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

  if typeof scale == 'undefined' || scale == 0
    scale = 100

  tsdb = window.tsdb()
  metric = tsdb.metric(query)
  horizon = context.horizon()
    .metric(metric)
    .extent([0, scale])
    .height(100)
  div.call(horizon)

$ ->
  $graph =$ '#ts-graph'

  tsdb = context.opentsdb($graph.data('server-url'))
  window.tsdb = ->
    tsdb

  $('.add-metric').bind('submit', addMetric)

  d3.select('#ts-graph').call (holder) ->
    holder.select('.axis').call(context.axis().orient('top'))
    holder.selectAll('.horizon').each ->
      loadMetric(this)
