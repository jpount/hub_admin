class HaproxyStats

  attr_accessor :lb_name
  attr_accessor :proxy_name
  attr_accessor :proxy_type
  attr_accessor :last_sec_reqs
  attr_accessor :high_reqs
  attr_accessor :tot_reqs
  attr_accessor :status
  attr_accessor :resp_100_rc
  attr_accessor :resp_200_rc
  attr_accessor :resp_300_rc
  attr_accessor :resp_400_rc
  attr_accessor :resp_500_rc
  attr_accessor :resp_other_rc

  def initialize
  end

  def last_high
    last_sec_reqs.to_s + "/" + high_reqs.to_s
  end

  def display_name
    disp_name = proxy_name + "/" + proxy_type
    if proxy_name == "fi_80"
      disp_name = "pacs002"
    elsif proxy_name == "fi_90"
      disp_name = "pacs008"
    elsif proxy_name == "api_80"
      disp_name = "pacs008 + pacs002"
    end
  end

  def lb_status
    status = 0
    if resp_100_rc > 0 || resp_300_rc > 0 || resp_400_rc > 0 || resp_500_rc > 0 || resp_other_rc > 0
      status = 2
    end
    status
  end
end
