require 'faraday'
class ApiMetricsController < ApplicationController
  protect_from_forgery except: [:ping]

  def ping
    error = true
    begin
      ip = params[:server]
      name = params[:name]
      if (!ip.blank? && !name.blank?)
        @metric = ApiMetric.new
        @metric.total_count = params[:total]
        @metric.success_count = params[:success]
        @metric.error_count = params[:error]
        @metric.ip = params[:server]
        @metric.msg_name = params[:name]
        @metric.last_entry_tps = params["last-entry-tps"]
        @metric.max_entry_tps = params["max-entry-tps"]
        @metric.last_exit_tps = params["last-exit-tps"]
        @metric.max_exit_tps = params["max-exit-tps"]
        create_dashboard_metric(@metric, Api.get_by_url(params[:server]), "Api")
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
    apimetrics_service = ApiMetricsService.new()
    apimetrics_service.clear_metrics
    redirect_to apimetrics_path, notice: 'Deleted all API metric data'
  end

  def reset_api_metrics
    apimetrics_service = ApiMetricsService.new()
    errors = apimetrics_service.reset_apis(get_timeout)
    msg = 'Resetting API metrics'
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
  end

  def get_common
    timeout = get_timeout
    @apis = DashboardMetric.get_valid_api_dashboard_metrics(timeout)
    @totalCount = 0
    @errorCount = 0
    @successCount = 0
    @apis.each do |api|
      @totalCount = @totalCount + api.total_count
      @successCount = @successCount + api.success_count
      @errorCount = @errorCount + api.error_count
    end
  end

  def get_008_common
    @latest008InMetrics = ApiMetric.get_latest_metrics("pacs008In")
    @latest008OutMetrics = ApiMetric.get_latest_metrics("pacs008Out")
  end

  def get_002_common
    @latest002InMetrics = ApiMetric.get_latest_metrics("pacs002In")
    @latest002OutMetrics = ApiMetric.get_latest_metrics("pacs002Out")
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

end

