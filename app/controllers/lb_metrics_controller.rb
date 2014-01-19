class LbMetricsController < ApplicationController
  protect_from_forgery except: [:stats]

  def stats
    @haproxy_stats = []
    error = ""
    begin
      haproxy = HaproxyStatsService.new(params)
      @haproxy_stats = haproxy.get_stats
    rescue => e
      error = "Could not get stats: " + e.message
    end
    respond_to do |format|
      format.html { render :stats }
      format.json {
      if !error.blank?
        render json: { status: :unprocessable_entity, errors: error }
      else
        render json: @haproxy_stats
      end
      }
    end
  end

end
