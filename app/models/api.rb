class Api < ActiveRecord::Base

  before_save :sanitize_url

  validates_presence_of :url
  has_many :api_metrics

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

  def api_type_enum
    ApiType::ALL_TYPES
  end

  def self.get_valid_apis ping_timeout
    Api.where("last_ping >= ?", Time.now.ago(ping_timeout) ).order('display_name, last_ping desc').all
  end

  def self.get_inactive_apis ping_timeout
    Api.where("last_ping < ?", Time.now.ago(ping_timeout)).order('display_name, last_ping desc').all
  end

  def self.get_all_apis
    Api.order('display_name, last_ping desc').all
  end

  def self.clear_apis
    Api.delete_all
  end

  def self.get_by_url url
    Api.
        where("url = ?", url).last
  end

  def self.remove_dead_apis ping_timeout
    Api.where("last_ping < ?", Time.now.ago(ping_timeout)).delete_all
  end

end
