require 'faraday'
class AdminController < ApplicationController
  before_action :populate_details, only: [:index, :launch]

  def index
  end

  def launch
    num_reqs = params[:request_count]
    tps = params[:tps]
    delay_secs = params[:delay]
    errors = false
    if (num_reqs.blank?)
      redirect_to root_path, alert: 'No of Requests must be entered'
    elsif ((tps.blank? && !delay_secs.blank?) || (!tps.blank? && delay_secs.blank?))
      redirect_to root_path, alert: 'If entered then both TPS and Delay must be entered'
    else
      @fis.each do |fi|
        if fi.fi_type == "SENDER" && !fi.ignore?
          begin
            start_fi(fi, num_reqs, fi.fi_org, tps, delay_secs)
          rescue => e
            errors = true
          end
        end
      end
      msg = 'FIs notified'
      msg = msg + " (errors encountered)" if errors
      redirect_to root_path, notice: msg
    end
  end

  private

  def populate_details
    timeout = get_timeout
    @fis = Fi.get_valid_fis(timeout)
    @apis = Api.get_valid_apis(timeout)
  end

  def start_fi(fi, num_reqs, code, tps, delay_secs)
    # start the FI sending msgs
    port = ":8080"
    url = "/hub-payment-fi-admin/paymentFI/admin/" + code + "/" + num_reqs.to_s
    base_url = ""
    begin
      if !fi.alt_url.blank?
        base_url = build_base_url(fi.alt_url, port) + url
      else
        base_url = build_base_url(fi.url, port) + url
      end
      if !tps.nil? && !tps.blank?
        base_url = base_url + "/" + tps
      end
      if !delay_secs.nil? && !delay_secs.blank?
        base_url = base_url + "/" + delay_secs
      end
      # send the message
      conn = get_connection()
      response = conn.post do |req|
        req.url base_url
        req.options[:timeout] = 20
        req.options[:open_timeout] = 20
      end
      if response.status != 200
        logger.error("Error response from FI: " + base_url)
        raise "Error launching FIs"
      end
    rescue => e
      logger.error("Error sending msg to FI: " + base_url + " - " + e.message)
      raise "Error launching FIs"
    end
  end

end
