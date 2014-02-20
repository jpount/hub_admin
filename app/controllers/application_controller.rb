require 'faraday'
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_timeout
    timeout = !Conf.first.nil? ? Conf.first.ping_interval * 2 : 120
  end

  def get_show_lb_stats
    show_stats = !Conf.first.nil? ? Conf.first.show_lb : false
  end

  def get_refresh_ms
    refresh_ms = !Conf.first.nil? ? Conf.first.dashboard_refresh_ms : 5000
  end

  def get_nimbus_url
    nimbus = !Conf.first.nil? ? Conf.first.nimbus_url : "localhost"
  end

  def get_cassandra_url
    cassandra = !Conf.first.nil? ? Conf.first.cassandra_url : "localhost"
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

  def create_dashboard_metric metric, existing_parent, override_type
    if (metric && !metric.ip.empty? && !metric.msg_name.empty?)
      @db_metric = DashboardMetric.get_by_ip_and_msg_name(metric.ip, metric.msg_name)
      if @db_metric.nil?
        @db_metric = DashboardMetric.new
      end
      if !existing_parent.nil?
        @db_metric.metricable_type = existing_parent.class_name
        @db_metric.metricable_id = existing_parent.id
      else
        @db_metric.metricable_type = override_type
      end
      @db_metric.total_count = metric.total_count
      @db_metric.success_count = metric.success_count
      @db_metric.error_count = metric.error_count
      @db_metric.ip = metric.ip
      @db_metric.msg_name = metric.msg_name
      @db_metric.last_entry_tps = metric.last_entry_tps
      @db_metric.max_entry_tps = metric.max_entry_tps
      @db_metric.last_exit_tps = metric.last_exit_tps
      @db_metric.max_exit_tps = metric.max_exit_tps
      @db_metric.save
    end
  end

end

