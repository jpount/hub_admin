class FiMetricsController < ApplicationController
  protect_from_forgery except: [:ping]

  # GET /fis
  # GET /fis.json
  def index
    get_common
  end

  def ping
    error = true
    begin
      ip = params[:server]
      name = params[:name]
      if (!ip.blank? && !name.blank?)
        @metric = Metric.new
        @metric.total_count = params[:total]
        @metric.success_count = params[:success]
        @metric.error_count = params[:error]
        @metric.ip = params[:server]
        @metric.msg_name = params[:name]
        @metric.last_entry_tps = params["last-entry-tps"]
        @metric.max_entry_tps = params["max-entry-tps"]
        @metric.last_exit_tps = params["last-exit-tps"]
        @metric.max_exit_tps = params["max-exit-tps"]
        create_dashboard_metric(@metric, Fi.get_by_url(params[:server]), "Fi")
        error = false
      else
        logger.warn("No ip and name specified: " + params.to_s)
      end
    rescue => e
      logger.warn("Could not save fi_metrics")
    end
    if !error && @metric.save
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def delete_all
    fimetrics_service = FiMetricsService.new()
    fimetrics_service.clear_metrics
    redirect_to fimetrics_path, notice: 'Deleted all FI metric data'
  end

  def reset_fi_metrics
    fimetrics_service = FiMetricsService.new()
    errors = fimetrics_service.reset_fis(get_timeout)
    msg = 'Resetting FI metrics'
    msg = msg + " (errors encountered)" if errors
    redirect_to fimetrics_path, notice: msg
  end

  private

  def get_common
    timeout = get_timeout
    @fis = DashboardMetric.get_valid_fi_dashboard_metrics(timeout)
    @totalCount = 0
    @errorCount = 0
    @successCount = 0
    @fis.each do |fi|
      @totalCount = @totalCount + fi.total_count
      @successCount = @successCount + fi.success_count
      @errorCount = @errorCount + fi.error_count
    end
  end

end
