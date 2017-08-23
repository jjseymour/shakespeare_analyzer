class Line
  attr_reader :content, :character

  @@all = []

  def initialize(content, character)
    @content = content
    @character = character
    @@all << self
  end
end
