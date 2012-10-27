require 'net/http'
class DoesRequests
  def get(url)
    parsed_url = URI.parse(url)
    Net::HTTP.get_response(parsed_url)
  end

  def post(url, args)
    parsed_url = URI.parse(url)
    Net::HTTP.post_form(parsed_url, args)
  end
end
