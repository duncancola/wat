class Artist
  attr_reader :id, :name, :releases, :image
  def initialize(id, name)
    @id = id
    @name = name
  end

  def initialize(id, name, releases)
    @id = id
    @name = name
    @releases = releases
  end

  def initialize(id, name, releases, image)
    @id = id
    @name = name
    @releases = releases
    @image = image
  end
end
