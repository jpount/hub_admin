class FiMetricsService < BaseService

  def initialize()
  end

  def clear_metrics
    Metric.clear_metrics
    DashboardMetric.clear_fi_metrics
  end

  def reset_fis(timeout_val)
    errors = false
    @fis = Fi.get_valid_fis(timeout_val)
    @fis.each do |fi|
      begin
        reset_metrics(fi)
      rescue => e
        errors = true
      end
    end
    errors
  end

  private

  def reset_metrics fi
    # reset the fi_metrics
    port = ":8080"
    rec_port = ":9090"
    begin
      conn = get_connection()
      if fi.fi_type == "SENDER"
        send_msg conn, build_send_url(fi, port, "/paymentFI/admin/admin/reset", "/hub-payment-fi-admin")
        send_msg conn, build_send_url(fi, port, "/paymentFI/settlement/receiver/admin/reset", "/hub-payment-fi-settlement-receiver")
        send_msg conn, build_send_url(fi, port, "/paymentFI/transfer/sender/admin/reset", "/hub-payment-fi-transfer-sender")
      elsif fi.fi_type == "RECEIVER"
        send_msg conn, build_send_url(fi, rec_port, "/paymentFI/transfer/receiver/admin/reset", "/hub-payment-fi-transfer-receiver")
        send_msg conn, build_send_url(fi, rec_port, "/paymentFI/settlement/sender/admin/reset", "/hub-payment-fi-transfer-receiver")
      end
    rescue => e
      logger.error(err)
      raise "Error resetting metrics"
    end
  end

end
