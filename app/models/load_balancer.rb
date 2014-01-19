class LoadBalancer < ActiveRecord::Base

  belongs_to :conf

  def get_proxy_type
    self.proxy_type.empty? ? "FRONTEND" : self.proxy_type
  end

  def get_proxy
    self.proxy_name.empty? ? "application" : self.proxy_name
  end

end
