class ApiMetricsService < BaseService

  def initialize()
  end

  def clear_metrics
    ApiMetric.clear_metrics
  end

  def reset_apis(timeout_val)
    errors = false
    apis = Api.get_valid_apis(timeout_val)
    apis.each do |api|
      begin
        reset_metrics(api)
      rescue => e
        errors = true
      end
    end
    errors
  end

  private

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

end
