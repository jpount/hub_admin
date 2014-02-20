class Fi < ActiveRecord::Base

  before_save :sanitize_url

  validates_presence_of :url
  has_one :metric

  def sanitize_url
    unless self.url.include?("http://") || self.url.include?("https://")
      self.url = "http://" + self.url
    end
    unless self.url.ends_with?("/")
      self.url = self.url + "/"
    end
    if !self.alt_url.blank?
      unless self.alt_url.include?("http://") || self.alt_url.include?("https://")
        self.alt_url = "http://" + self.alt_url
      end
      unless self.alt_url.ends_with?("/")
        self.alt_url = self.alt_url + "/"
      end
    end
  end

  def fi_type_enum
    FiType::ALL_TYPES
  end

  def fi_org_enum
    FiOrg::ALL_TYPES
  end

  def self.get_by_url url
    Fi.
        where("url = ?", url).last
  end

  def self.get_valid_fis ping_timeout
    Fi.where("last_ping >= ?", Time.now.ago(ping_timeout) ).order('display_name, last_ping desc').all
  end

  def self.get_inactive_fis ping_timeout
    Fi.where("last_ping < ?", Time.now.ago(ping_timeout)).order('display_name, last_ping desc').all
  end

  def self.get_all_fis
    Fi.order('display_name, last_ping desc').all
  end

  def self.clear_fis
    Fi.delete_all
  end

  def self.remove_dead_fis ping_timeout
    Fi.where("last_ping < ?", Time.now.ago(ping_timeout)).delete_all
  end

  def get_008_count
    !metric.nil? ? metric.total_pacs_8_sent + metric.total_pacs_8_errors : 0
  end

  def get_002_count
    !metric.nil? ? metric.total_pacs_2_sent + metric.total_pacs_2_errors : 0
  end

  def get_total_count
    !metric.nil? ? metric.total_count : 0
  end

  def get_total_errors
    !metric.nil? ? metric.total_errors : 0
  end

  def get_last_successful_fetch
    !metric.nil? ? metric.last_successful_fetch : nil
  end

end
