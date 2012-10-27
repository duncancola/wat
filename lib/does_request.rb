require 'net/http'
class DoesRequests
  def self.get(url)
    parsed_url = URI.parse(url)
    Net::HTTP.get_response(parsed_url)
  end

  def self.post(url, args)
    parsed_url = URI.parse(url)
    Net::HTTP.post_form(parsed_url, args)
  end
end
