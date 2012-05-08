module ServersHelper
  def build_graph(server, metric, aggregator, start_time, end_time)
    query = "#{aggregator}:#{metric}"
    content_tag :div, "", :class => "cubism-graph", :"data-query" => query, :"data-server" => server.to_s
  end
end
