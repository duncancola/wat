class Artist
  attr_reader :id, :name, :releases
  def initialize(id, name)
    @id = id
    @name = name
  end

  def initialize(id, name, releases)
    @id = id
    @name = name
    @releases = releases
  end
end
