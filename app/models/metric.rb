class Metric < ActiveRecord::Base
  belongs_to :fi

  def self.get_by_ip ip
    Metric.
        where("ip = ?", ip).last
  end

  def self.get_by_ip_and_msg_name ip, name
    Metric.
        where("ip = ? and msg_name = ?", ip, name).last
  end

  def self.clear_metrics
    Metric.delete_all
  end

  def self.get_valid_metrics ping_timeout
    Metric.includes(:fi).where("updated_at >= ?", Time.now.ago(ping_timeout) ).order('ip, updated_at desc').all
  end

end

