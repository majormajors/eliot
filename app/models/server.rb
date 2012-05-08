class Server < ActiveRecord::Base
  attr_accessible :base_url, :name

  has_many :graphs

  def aggregators(format=:json)
    http_get("/aggregators", format)
  end

  def logs(format=:json)
    http_get("/logs", format)
  end

  def suggest(query='', type=:metrics, format=:json)
    http_get("/suggest?q=%s&type=%s" % [query, type], format)
  end

  def version
    http_get("/version")
  end

  def query(query, start_time, end_time=Time.now.getutc)
    query_string = "/q?m=%s&start=%s&end=%s&%%s" % [ query, format_query_time(start_time), format_query_time(end_time) ]
    results = http_get(query_string % [ "json" ], :json)

    if results
      results.symbolize_keys!
      response = http_get(query_string % [ 'ascii' ], :ascii)
      results[:results] = parse_query_results(response)
    end

    results
  end

  def to_s
    self.base_url.to_s
  end

private

  def tsdb
    @tsdb ||= Faraday.new(:url => self.base_url) do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Adapter::NetHttp
    end
  end

  def http_get(url, format=:plain)
    response = tsdb.get(url)

    if response.status != 200
      return nil
    end

    case format
    when :json
      JSON.parse(response.body)
    else
      response.body
    end
  end

  def format_query_time(time)
    time.getutc.strftime("%Y/%m/%d-%H:%M:%S")
  end

  def parse_query_results(response)
    results = response.scan(/^(\S+)\s+(\d{10})\s+(\d+(?:\.\d+)?)\s+(.+)$/)
    results.map do |row|
      {
        :name => row[0],
        :time => Time.at(row[1].to_i),
        :value => row[2].to_f,
        :tags => Hash[ *row[3].split(/=|\s/) ].symbolize_keys
      }
    end
  end
end
