module AdminHelper

  def fi_metric_popup(fi)
    metric_txt = ""
    metric = fi.metric
    line_break = "<br/>"
    comma = ", "
    if (metric != nil)
      metric_txt = metric_txt + "Errors - Admin:" + metric.admin_errors.to_s + comma + " File:"  + metric.file_errors.to_s + comma + " General:"  + metric.general_errors.to_s + line_break
      metric_txt = metric_txt + "Totals - Count:" + metric.total_count.to_s + comma + " Errors:"  + metric.total_errors.to_s + line_break
      metric_txt = metric_txt + "Pacs008 - Sent:" + metric.total_pacs_8_sent.to_s + comma + " Received:"  + metric.total_pacs_8_received.to_s + comma + " Errors:"  + metric.total_pacs_8_errors.to_s + line_break
      metric_txt = metric_txt + "Pacs002 - Sent:" + metric.total_pacs_2_sent.to_s + comma + " Received:"  + metric.total_pacs_2_received.to_s + comma + " Errors:"  + metric.total_pacs_2_errors.to_s + line_break
    end
    metric_txt
  end

  def get_haproxy_link
    apimetrics_lb_path
  end

  def tps_calc(last_tps_cnt, last_tps_date, total_count, updated_at)
    tps = 0
    if last_tps_cnt == 0 || last_tps_date.blank?
      # dont know the period so either default to something or leave as 0
    else
      begin
        # tps = diff between the last two amounts / diff in secs between the 2 dates
        secs_diff = (updated_at.minus_with_coercion(last_tps_date)).round
        amounts_diff = total_count - last_tps_cnt
        tps =  (amounts_diff / secs_diff).round
      rescue => e
        tps = 0
      end
    end
    tps
  end

  def tps_ip_calc(metrics, ip)
    tps = 0
    first_amt = 0
    final_amt = 0
    first_date = ""
    last_date = ""
    metrics.each do |met|
      if (met.ip == ip)
        final_amt = met.total_count
        if first_date.blank?
          first_date = met.updated_at
          first_amt = met.total_count
        end
        last_date = met.updated_at
      end
    end
    final_amt = final_amt - first_amt
    if !first_date.blank? && !last_date.blank? && final_amt > 0
      secs_diff = (last_date.minus_with_coercion(first_date)).round
      tps = (final_amt / secs_diff).round
    end
    tps
  end

  def get_cassandra_url
    cassandra = !Conf.first.nil? ? Conf.first.cassandra_url : "localhost"
  end

end
