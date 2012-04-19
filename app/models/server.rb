class Server < ActiveRecord::Base
  attr_accessible :base_url, :name

  def aggregators(format=:json)
    http_get("/aggregators", format)
  end

  def logs(format=:json)
    http_get("/logs", format)
  end

  def suggest(query='', type=:metrics, format=:json)
    http_get("/suggest?q=%s&type=%s" % [query, type], format)
  end

  def version(format=:json)
    http_get("/version", format)
  end

private

  def connection
    @connection ||= Faraday.new(:url => self.base_url) do |builder|
      builder.use Faraday::Request::UrlEncoded
      builder.use Faraday::Adapter::NetHttp
    end
  end

  def http_get(url, format)
    response = connection.get(url)

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
end
