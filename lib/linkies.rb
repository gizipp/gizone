module Linkies
  def self.response_code(url)
    url = URI(url)
    response = nil
    Net::HTTP.start(url.host, url.port) do |http|
     response = http.head(url)
    end
    response.code
  end
end