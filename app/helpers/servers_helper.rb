module ServersHelper
  def build_graph(server, metric, aggregator, start_time, end_time)
    query = "#{aggregator}:#{metric}"
    results = server.query(query, 2.hours.ago, Time.now)

    results
  end
end
