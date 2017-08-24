class Play
  attr_reader :title, :characters, :error

  @@all = []

  def self.all
    @@all
  end

  def self.find_or_create_by_title(title)
    found_play = find_by_title(title)
    return found_play if found_play
    self.new(title)
  end

  def self.find_by_index(index)
    begin
      found_play = all[index]
    rescue Exception => e
      puts e
    end
    found_play
  end

  def initialize(title)
    @title = title
    @characters = []
    @@all << self
  end

  def find_or_create_character(name)
    Character.find_or_create_by_name(name, self)
  end

  def sorted_characters
    characters.sort_by! { |character| character.lines_count }.reverse!
  end

  def output_lines_per_character
    characters.each { |character| puts "#{character.lines_count} #{character.name}" }
  end

  private

  def self.find_by_title(title)
    all.find { |play| play.title == title }
  end

end
