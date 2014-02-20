class DashboardsController < ApplicationController
  protect_from_forgery

  def index
    fis
    apis
  end

  def reset_fis
    fimetrics_service = FiMetricsService.new()
    errors = fimetrics_service.reset_fis(get_timeout)
    fimetrics_service.clear_metrics
    msg = 'Resetting FI metrics'
    msg = msg + " (errors encountered)" if errors
    redirect_to dashboard_path, notice: msg
  end

  def reset_apis
    apimetrics_service = ApiMetricsService.new()
    errors = apimetrics_service.reset_apis(get_timeout)
    apimetrics_service.clear_metrics
    msg = 'Resetting API metrics'
    msg = msg + " (errors encountered)" if errors
    redirect_to dashboard_path, notice: msg
  end

  def fi_metrics
    fis
    respond_to do |format|
      format.js {
      }
    end
  end

  def api_metrics
    apis
    respond_to do |format|
      format.js {
      }
    end
  end

  def dashboard_counts
    apis
    fis
    respond_to do |format|
      format.js {
      }
    end
  end

  def apis
    timeout = get_timeout
    @apis = DashboardMetric.get_api_dashboard_metrics(timeout)
  end

  def fis
    timeout = get_timeout
    @fis = DashboardMetric.get_fi_dashboard_metrics(timeout)
  end

end
