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
        @metric = Metric.get_by_ip_and_msg_name(params[:server], params[:name])
        if (@metric == nil)
          @metric = Metric.new
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
      logger.warn("Could not save fi_metrics")
    end
    if !error && @metric.save
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def delete_all
    Metric.clear_metrics
    redirect_to fimetrics_path, notice: 'Deleted all FI metric data'
  end

  def reset_fi_metrics
    errors = false
    @fis = Fi.get_valid_fis(get_timeout)
    @fis.each do |fi|
      begin
        reset_metrics(fi)
      rescue => e
        errors = true
      end
    end
    msg = 'Resetting FI metrics'
    msg = msg + " (errors encountered)" if errors
    redirect_to fimetrics_path, notice: msg
  end

  private

  def get_common
    timeout = get_timeout
    @fis = Metric.get_valid_metrics(timeout)
    @totalCount = 0
    @errorCount = 0
    @successCount = 0
    @fis.each do |fi|
      @totalCount = @totalCount + fi.total_count
      @successCount = @successCount + fi.success_count
      @errorCount = @errorCount + fi.error_count
    end
  end

  def reset_metrics fi
    # reset the fi_metrics
    port = ":8080"
    begin
      conn = get_connection()
      if fi.fi_type == "SENDER"
        send_msg conn, build_send_url(fi, port, "/paymentFI/admin/admin/reset", "/hub-payment-fi-admin")
        send_msg conn, build_send_url(fi, port, "/paymentFI/settlement/receiver/admin/reset", "/hub-payment-fi-settlement-receiver")
        send_msg conn, build_send_url(fi, port, "/paymentFI/transfer/sender/admin/reset", "/hub-payment-fi-transfer-sender")
      elsif fi.fi_type == "RECEIVER"
        send_msg conn, build_send_url(fi, port, "/paymentFI/transfer/receiver/admin/reset", "/hub-payment-fi-transfer-receiver")
        send_msg conn, build_send_url(fi, port, "/paymentFI/settlement/sender/admin/reset", "/hub-payment-fi-transfer-receiver")
      end
    rescue => e
      err = "Could not reset fi metrics : " + e.message
      logger.error(err)
      raise "Error resetting metrics"
    end
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

end
