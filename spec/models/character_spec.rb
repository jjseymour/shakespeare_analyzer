require 'rails_helper'

RSpec.describe Character, :type => :model do
  before(:each) do
    @name = "First Witch"
    @play = Play.new("Some Play")
    @character = Character.new(@name, @play)
    @line = Line.new("Something Glorious!", @character)
  end

  after(:each) do
    @play.characters.clear
    Play.class_variable_get(:@@all).clear
    @character.lines.clear
    Character.class_variable_get(:@@all).clear
    Line.class_variable_get(:@@all).clear
  end

  describe 'initialize' do
    it 'initializes with a name, play and empty array for lines' do
      expect(@character.instance_variable_get(:@name)).to include(@name)
      expect(@character.instance_variable_get(:@play)).to equal(@play)
      expect(@character.instance_variable_get(:@lines)).to be_a_kind_of(Array)
    end

    it 'adds the character to the `all` class variable' do
      expect(Character.class_variable_get(:@@all)).to include(@character)
    end
  end

  describe '.all' do
    it 'returns the `all` class variable' do
      expect(Character.all).to equal(Character.class_variable_get(:@@all))
    end
  end

  describe '.find_or_create_by_name' do
    it 'returns the first object found matching the string passed in' do
      expect(Character.find_or_create_by_name(@name, @play)).to eql(@character)
    end

    it 'creates a new play object if nothing was found' do
      new_char = Character.find_or_create_by_name('Henry Ford', @play)
      expect(new_char).to_not eql(@character)
      expect(Character.find_or_create_by_name('Henry Ford', @play)).to eql(new_char)
    end
  end

  describe '#add_line' do
    it 'adds a new line object to the lines array' do
      @character.add_line('Amazing.')
      expect(@character.lines.last.content).to eql('Amazing.')
    end
  end

  describe '#lines_count' do
    it 'returns a count of the line objects in the lines array' do
      expect(@character.lines_count).to eql(0)
      @character.add_line('Amazing.')
      expect(@character.lines_count).to eql(1)
    end
  end
end
