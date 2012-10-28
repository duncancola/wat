class Track
  attr_reader :id, :title, :preview
  def initialize(id, title)
    @id = id
    @title = title
  end

  def initialize(id, title, preview)
    @id = id
    @title = title
    @preview = preview
  end
end
