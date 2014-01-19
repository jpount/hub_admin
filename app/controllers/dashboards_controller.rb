class DashboardsController < ApplicationController
  protect_from_forgery

  def lb_stats
    stats = []
    haproxy_stats = []
    error = ""
    begin
      haproxy = HaproxyStatsService.new(params)
      haproxy_stats = haproxy.get_stats
      haproxy_stats.each do |hap|
        stat = DashboardStat.new
        stat.label = hap.lb_name
        stat.value = hap.last_high
        stat.status = hap.lb_status
        stats << stat
      end
    rescue => e
      error = "Could not get stats: " + e.message
    end
    respond_to do |format|
      format.html { render :stats }
      format.json {
        if !error.blank?
          render json: { status: :unprocessable_entity, errors: error }
        else
          render json: stats
        end
      }
    end
  end

  def get_008_in_count
    db_cnt = get_api_total("pacs008In", "TOTAL")
    respond_to do |format|
      format.json {
        render json: db_cnt
      }
    end
  end

  def get_008_out_count
    db_cnt = get_api_total("pacs008Out", "TOTAL")
    respond_to do |format|
      format.json {
        render json: db_cnt
      }
    end
  end

  def get_008_out_error_count
    db_cnt = get_api_total("pacs008Out", "ERROR")
    respond_to do |format|
      format.json {
        render json: db_cnt
      }
    end
  end

  def get_002_in_count
    db_cnt = get_api_total("pacs002In", "TOTAL")
    respond_to do |format|
      format.json {
        render json: db_cnt
      }
    end
  end

  def get_002_out_count
    db_cnt = get_api_total("pacs002Out", "TOTAL")
    respond_to do |format|
      format.json {
        render json: db_cnt
      }
    end
  end

  def get_002_out_error_count
    db_cnt = get_api_total("pacs002Out", "ERROR")
    respond_to do |format|
      format.json {
        render json: db_cnt
      }
    end
  end

  def get_api_total (name, type)
    db_cnt = DashboardCount.new
    db_cnt.label = name
    db_cnt.counter = type
    db_cnt.value = ApiMetric.get_safe_total(name, type)
    db_cnt
  end

end