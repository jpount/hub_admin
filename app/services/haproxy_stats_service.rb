require 'csv'
require 'open-uri'
class HaproxyStatsService

  def initialize(params)
    @params = params
  end

  def get_stats
    found_proxies = []
    stats = []
    conf = Conf.first
    if (conf && conf.load_balancers.size > 0)
      conf.load_balancers.each do |lb|
        proxy_type = lb.get_proxy_type
        proxy = lb.get_proxy
        begin
          timeout(5) do
            CSV.parse(open( lb.url + "/;csv",:http_basic_authentication => [ lb.user_name, lb.password ]), :headers => true) do |row|
              next if proxy_type and proxy_type != row["svname"] # ensure the proxy type (if provided) matches
              next unless proxy.to_s.strip.downcase == row["# pxname"].downcase # ensure the proxy name matches
              found_proxies << row["# pxname"]
              hap = HaproxyStats.new
              hap.lb_name = lb.display_name
              hap.proxy_name = row['# pxname']
              hap.proxy_type = row['svname']
              hap.last_sec_reqs = row['req_rate'].to_i
              hap.high_reqs = row['req_rate_max'].to_i
              hap.tot_reqs = row['req_tot'].to_i
              hap.status = row['status']
              hap.resp_100_rc = row['hrsp_1xx'].to_i
              hap.resp_200_rc = row['hrsp_2xx'].to_i
              hap.resp_300_rc = row['hrsp_3xx'].to_i
              hap.resp_400_rc = row['hrsp_4xx'].to_i
              hap.resp_500_rc = row['hrsp_5xx'].to_i
              hap.resp_other_rc = row['hrsp_other'].to_i
              stats << hap
            end
          end
        rescue OpenURI::HTTPError
          if $!.message == '401 Unauthorized'
            raise 'Authentication Failed - Unable to access the stats page at: ' + hapuri
          elsif $!.message != '404 Not Found'
            raise 'Unable to find the stats page - The stats page could not be found at: ' + hapuri
          else
            raise $!.message
          end
        rescue TimeoutError
          raise 'Request timed out'
        rescue CSV::MalformedCSVError
          raise 'Unable to access stats page: ' + $!.message
        end
      end
    end
    return stats
  end

end
