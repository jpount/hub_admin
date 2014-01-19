require 'faraday'
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_timeout
    timeout = !Conf.first.nil? ? Conf.first.ping_interval * 2 : 120
  end

  def get_nimbus_url
    nimbus = !Conf.first.nil? ? Conf.first.nimbus_url : "localhost"
  end

  def get_cassandra_url
    cassandra = !Conf.first.nil? ? Conf.first.cassandra_url : "localhost"
    puts "cassandra: " + cassandra
  end

  def get_conf
    conf = Conf.first
  end

  def sanitize_url (url)
    resp_url = url
    unless url.include?("http://") || url.include?("https://")
      resp_url = "http://" + resp_url
    end
    unless url.ends_with?("/")
      resp_url = resp_url + "/"
    end
    resp_url
  end

  def add_port base_url, port, main_url
    url = base_url.chop + port + main_url
  end

  def build_base_url base_url, port
    url = base_url.chop + port
  end

  def get_connection()
    conn = Faraday.new() do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    conn
  end

end

