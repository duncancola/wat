require File.expand_path(File.dirname(__FILE__) + '/does_requests.rb')
require File.expand_path(File.dirname(__FILE__) + '/seven_digital_rest.rb')
require File.expand_path(File.dirname(__FILE__) + '/artist.rb')
require 'nokogiri'

class MusicFactory
  def initialize(xml_store)
    @xml_store = xml_store
  end

  def get_artists_for_genre(genre)
    artists_xml = @xml_store.get_artists_for_genre(genre).body
    xml = Nokogiri::XML(artists_xml)
    artists = []
    xml.xpath('//artist').each do |node|
      id = node[:id]
      name = node.xpath('name').first.text
      artists << Artist.new(id, name)
    end
    artists
  end
end

mf = MusicFactory.new(SevenDigitalRest.new(DoesRequests.new))
artists = mf.get_artists_for_genre("rock")
puts "-------____"
puts artists
