class ApiMetric < ActiveRecord::Base

  belongs_to :api

  def self.clear_metrics
    ApiMetric.delete_all
  end

  def self.get_by_ip ip
    ApiMetric.
        where("ip = ?", ip).last
  end

  def self.get_by_ip_and_msg_name ip, name
    ApiMetric.
        where("ip = ? and msg_name = ?", ip, name).last
  end

  def self.get_by_name name
    ApiMetric.
        where("msg_name = ?", name).group(:ip)
  end

  def self.get_last_by_name name
    ApiMetric.
        where("msg_name = ?", name).group(:ip)
  end

  def self.get_latest_metrics (name)
    ApiMetric.includes(:api).
        where("msg_name = ?", name).order("ip ASC, updated_at ASC")
  end

  def self.get_max_points name
    ApiMetric.
        select("count(*) as 'cnt', ip").
        where("msg_name = ?", name).
        group(:ip)
  end

  def self.get_total
    total = 0
    total = total + get_safe_total("pacs008In", "TOTAL")
    total = total + get_safe_total("pacs008Out", "TOTAL")
    total = total + get_safe_total("pacs002In", "TOTAL")
    total = total + get_safe_total("pacs002Out", "TOTAL")
    total
  end

  def self.get_error_count
    total = 0
    total = total + get_safe_total("pacs008In", "ERROR")
    total = total + get_safe_total("pacs008Out", "ERROR")
    total = total + get_safe_total("pacs002In", "ERROR")
    total = total + get_safe_total("pacs002Out", "ERROR")
    total
  end

  def self.get_success_count
    total = 0
    total = total + get_safe_total("pacs008In", "SUCCESS")
    total = total + get_safe_total("pacs008Out", "SUCCESS")
    total = total + get_safe_total("pacs002In", "SUCCESS")
    total = total + get_safe_total("pacs002Out", "SUCCESS")
    total
  end

  def self.get_safe_total (metric_name, type)
    total = 0
    if (!name.blank?)
      metrics = ApiMetric.get_last_by_name(metric_name)
      metrics.each do |metric|
        if (!metric.nil?)
          if (type == "ERROR")
            total = total + metric.error_count
          elsif (type == "SUCCESS")
            total = total + metric.success_count
          elsif (type == "TOTAL")
            total = total + metric.total_count
          end
        end
      end
    end
    total
  end

end
