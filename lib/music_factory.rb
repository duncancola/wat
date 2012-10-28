require File.expand_path(File.dirname(__FILE__) + '/does_requests.rb')
require File.expand_path(File.dirname(__FILE__) + '/seven_digital_rest.rb')
require File.expand_path(File.dirname(__FILE__) + '/artist.rb')
require File.expand_path(File.dirname(__FILE__) + '/release.rb')
require File.expand_path(File.dirname(__FILE__) + '/track.rb')
require 'nokogiri'

class MusicFactory
  def initialize(xml_store)
    @xml_store = xml_store
  end

  def get_artists_single_track(genre)
    puts "get single artist track"
    artists_xml = @xml_store.get_artists_for_genre(genre).body
    xml = Nokogiri::XML(artists_xml)
    artists = []
    xml.xpath('//artist').each do |node|
      id = node[:id]
      name = node.xpath('name').first.text
      releases = get_single_release(id)
      artists << Artist.new(id, name, releases)
    end
    artists
  end

  def get_artists_for_genre(genre)
    artists_xml = @xml_store.get_artists_for_genre(genre).body
    xml = Nokogiri::XML(artists_xml)
    artists = []
    xml.xpath('//artist').each do |node|
      id = node[:id]
      name = node.xpath('name').first.text
      releases = get_releases(id)
      artists << Artist.new(id, name, releases)
    end
    artists
  end

  def get_single_release(artist_id)
    puts "get single release"
    releases_xml = @xml_store.get_releases(artist_id).body
    xml = Nokogiri::XML(releases_xml)
    node = xml.xpath('//release').first
    id = node[:id]
    title = node.xpath('title').first.text
    year = node.xpath('year').first.text
    image = node.xpath('image').first.text
    tracks = get_single_track(id)
    Release.new(id, title, year, image, tracks)
  end

  def get_releases(artist_id)
    releases_xml = @xml_store.get_releases(artist_id).body
    xml = Nokogiri::XML(releases_xml)
    releases = []
    xml.xpath('//release').each do |node|
      id = node[:id]
      title = node.xpath('title').first.text
      year = node.xpath('year').first.text
      image = node.xpath('image').first.text
      tracks = get_tracks(id)
      releases << Release.new(id, title, year, image, tracks)
    end
    releases
  end

  def get_single_track(release_id)
    puts "single track"
    tracks_xml = @xml_store.get_tracks(release_id).body
    xml = Nokogiri::XML(tracks_xml)
    node = xml.xpath('//track').first
    id = node[:id]
    title = node.xpath('title').first.text
    preview = get_track_preview(id)
    Track.new(id, title, preview)
  end

  def get_tracks(release_id)
    tracks_xml = @xml_store.get_tracks(release_id).body
    xml = Nokogiri::XML(tracks_xml)
    tracks = []
    xml.xpath('//track').each do |node|
      id = node[:id]
      title = node.xpath('title').first.text
      preview = get_track_preview(id)
      tracks << Track.new(id, title, preview)
    end
    tracks
  end

  def get_track_preview(track_id)
    puts "previw"
    preview_xml = @xml_store.get_track_preview(track_id).body
    xml = Nokogiri::HTML(preview_xml)
    xml.xpath('//url').first.text
  end
end

