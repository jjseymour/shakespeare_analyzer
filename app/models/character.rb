class Character
  attr_reader :name, :lines, :play

  @@all = []

  def self.all
    @@all
  end

  def self.find_or_create_by_name(name, play)
    found_char = all.find { |character| character.name == name }
    return found_char if found_char
    self.new(name, play)
  end

  def initialize(name, play)
    @name = name
    @play = play
    @lines = []
    @play.characters << self
    @@all << self
  end

  def add_line(line)
    @lines << Line.new(line, self)
  end

  def lines_count
    lines.length
  end
end
