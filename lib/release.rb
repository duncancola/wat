class Release
  attr_reader :id, :title, :year, :image, :tracks
  def initialize(id, title, year, image)
    @id = id
    @title = title
    @year = year
    @image = image
  end

  def initialize(id, title, year, image, tracks)
    @id = id
    @title = title
    @year = year
    @image = image
    @tracks = tracks
  end
end
