class DashboardMetric < ActiveRecord::Base

  def self.clear_metrics
    DashboardMetric.delete_all
  end

  def self.get_by_ip_and_msg_name ip, name
    DashboardMetric.
        where("ip = ? and msg_name = ?", ip, name).last
  end

  def self.get_fi_dashboard_metrics ping_timeout
    DashboardMetric.where("updated_at >= ? and msg_name not like 'paymentInternal%' and msg_name not like '%admin-msgs%' and metricable_type = 'Fi'", Time.now.ago(ping_timeout) ).order('msg_name desc').all
  end

  def self.get_api_dashboard_metrics ping_timeout
    DashboardMetric.where("updated_at >= ? and metricable_type = 'Api'", Time.now.ago(ping_timeout) ).order('msg_name asc').all
  end

  def self.get_valid_fi_dashboard_metrics ping_timeout
    DashboardMetric.where("updated_at >= ? and metricable_type = 'Fi'", Time.now.ago(ping_timeout) ).order('msg_name asc').all
  end

  def self.get_valid_api_dashboard_metrics ping_timeout
    DashboardMetric.where("updated_at >= ? and metricable_type = 'Api'", Time.now.ago(ping_timeout) ).order('msg_name asc').all
  end

  def self.clear_api_metrics
    DashboardMetric.delete_all("metricable_type = 'Api'")
  end

  def self.clear_fi_metrics
    DashboardMetric.delete_all("metricable_type = 'Fi'")
  end

end
