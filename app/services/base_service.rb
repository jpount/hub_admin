require 'faraday'
class BaseService

  def initialize()
  end

  def build_send_url fi, port, url_append, context
    built_url = ""
    if !fi.alt_url.blank?
      built_url = build_base_url(fi.alt_url, port) + context + url_append
    else
      built_url = build_base_url(fi.url, port) + context + url_append
    end
    built_url
  end

  def send_msg cxn, send_url
    response = cxn.post do |req|
      req.url send_url
      req.options[:timeout] = 20
      req.options[:open_timeout] = 20
    end
  end

  def get_connection()
    conn = Faraday.new() do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn
  end

  def add_port base_url, port, main_url
    url = base_url.chop + port + main_url
  end

  def build_base_url base_url, port
    url = base_url.chop + port
  end

end
