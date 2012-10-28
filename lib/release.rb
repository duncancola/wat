class Release
  attr_reader :id, :title, :year, :image
  def initialize(id, title, year, image)
    @id = id
    @title = title
    @year = year
    @image = image
  end
end
