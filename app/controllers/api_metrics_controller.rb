require 'faraday'
class ApiMetricsController < ApplicationController
  protect_from_forgery except: [:ping]

  def ping
    error = true
    begin
      ip = params[:server]
      name = params[:name]
      if (!ip.blank? && !name.blank?)
        @metric = ApiMetric.get_by_ip_and_msg_name(params[:server], params[:name])
        if (@metric == nil)
          @metric = ApiMetric.new
        end
        @metric.total_count = params[:total]
        @metric.success_count = params[:success]
        @metric.error_count = params[:error]
        @metric.ip = params[:server]
        @metric.msg_name = params[:name]
        @metric.last_entry_tps = params["last-entry-tps"]
        @metric.max_entry_tps = params["max-entry-tps"]
        @metric.last_exit_tps = params["last-exit-tps"]
        @metric.max_exit_tps = params["max-exit-tps"]
        error = false
      else
        logger.warn("No ip and name specified: " + params.to_s)
      end
    rescue => e
      logger.warn("Could not save api_metrics")
    end
    if !error && @metric.save
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def index
    get_common
    get_008_common
    get_002_common
  end

  def chartpacs008
    get_008_common
    @max008In = get_max_points("pacs008In")
    @max008Out = get_max_points("pacs008Out")
    respond_to do |format|
      format.html {  }
      format.json { render :json => {:max_in => @max008In, :max_out => @max008Out} }
    end
  end

  def chartpacs002
    get_002_common
    @max002In = get_max_points("pacs002In")
    @max002Out = get_max_points("pacs002Out")
    respond_to do |format|
      format.html {  }
      format.json { render :json => {:max_in => @max002In, :max_out => @max002Out} }
    end
  end

  def delete_all
    ApiMetric.clear_metrics
    redirect_to apimetrics_path, notice: 'Deleted all API metric data'
  end

  def reset_api_metrics
    apis = Api.get_valid_apis(get_timeout)
    errors = false
    apis.each do |api|
      begin
        reset_metrics(api)
      rescue => e
        errors = true
      end
    end
    msg = 'Resetting API counts'
    msg = msg + " (errors encountered)" if errors
    redirect_to apimetrics_path, notice: msg
  end

  def lb
    @haproxy_stats = []
    error = ""
    begin
      haproxy = HaproxyStatsService.new(params)
      @haproxy_stats = haproxy.get_stats
    rescue => e
      error = "Could not get stats: " + e.message
    end
  end

  private

  def get_common
    @pac008In = ApiMetric.get_by_name("pacs008In")
    @pac008Out = ApiMetric.get_by_name("pacs008Out")
    @pac002In = ApiMetric.get_by_name("pacs002In")
    @pac002Out = ApiMetric.get_by_name("pacs002Out")
    @totalCount = ApiMetric.get_total
    @ErrorCount = ApiMetric.get_error_count
    @SuccessCount = ApiMetric.get_success_count
  end

  def get_008_common
    @latest008InMetrics = ApiMetric.get_latest_metrics("pacs008In")
    @latest008OutMetrics = ApiMetric.get_latest_metrics("pacs008Out")
  end

  def get_002_common
    @latest002InMetrics = ApiMetric.get_latest_metrics("pacs002In")
    @latest002OutMetrics = ApiMetric.get_latest_metrics("pacs002Out")
  end

  def reset_metrics api
    # reset the api_metrics
    begin
      if !api.url.blank?
        port = ":8080"
        conn = get_connection()
        if api.api_type == "IN"
          api_in_tfr_url = build_base_url(api.url, port) + "/hub-payment-consumer/paymentHub/consumer/transfer/admin/reset"
          api_in_stlmt_url = build_base_url(api.url, port) + "/hub-payment-consumer/paymentHub/consumer/settlement/admin/reset"
          send_msg conn, api_in_tfr_url
          send_msg conn, api_in_stlmt_url
        elsif api.api_type == "OUT"
          api_out_tfr_url = build_base_url(api.url, port) + "/hub-payment-producer/paymentHub/producer/transfer/admin/reset"
          api_out_stlmt_url = build_base_url(api.url, port) + "/hub-payment-producer/paymentHub/producer/settlement/admin/reset"
          send_msg conn, api_out_tfr_url
          send_msg conn, api_out_stlmt_url
        end
      end
    rescue => e
      err = "Could not reset api metrics : " + e.message
      logger.error(err)
      raise "Error resetting api metrics"
    end
  end

  def get_max_points name
    max = 0
    ip_points = ApiMetric.get_max_points(name)
    ip_points.each do |pt|
      if (pt.cnt > max)
        max = pt.cnt
      end
    end
    max
  end

  def send_msg cxn, send_url
    response = cxn.post do |req|
      req.url send_url
      req.options[:timeout] = 20
      req.options[:open_timeout] = 20
    end
  end

end

