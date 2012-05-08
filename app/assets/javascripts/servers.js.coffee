# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  context = cubism.context().serverDelay(30 * 1000).step(3000).size(960)
  formatter = d3.time.format('%Y/%m/%d-%X')

  $graphs =$ '.cubism-graph'
  $graphs.each (index)->
    $this =$ this
    query = $this.data('query')
    server = $this.data('server')
    tsdb = context.opentsdb(server)
    metric = tsdb.metric(query)
    d3.select('.cubism-graph').call (div)->
      div.append('div').attr('class', 'axis').call(context.axis().orient('top'))
      div.selectAll('.horizon').data([metric]).enter().append('div').attr('class', 'horizon').call(
        context.horizon().extent([50, 200]).height(400))
      div.append('div').attr('class', 'rule').call(context.rule())
      @
    @

