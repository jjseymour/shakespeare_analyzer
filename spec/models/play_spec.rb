require 'rails_helper'

RSpec.describe Play, :type => :model do
  before(:each) do
    @title = "I wrote something!"
    @play = Play.new(@title)
    @character = Character.new('Nikola Tesla', @play)
  end

  after(:each) do
    @play.characters.clear
    Play.class_variable_get(:@@all).clear
    Character.class_variable_get(:@@all).clear
  end

  describe 'initialize' do
    it 'initializes with a title argument' do
      expect(@play.instance_variable_get(:@title)).to equal(@title)
    end

    it 'instantiates an empty characters array' do
      expect(@play.instance_variable_get(:@characters)).to be_a_kind_of(Array)
    end

    it 'adds the play to `all` class variable' do
      expect(Play.class_variable_get(:@@all)).to include(@play)
    end
  end

  describe '#all' do
    it 'returns the `all` class variable' do
      expect(Play.all).to equal(Play.class_variable_get(:@@all))
    end
  end

  describe '#find_or_create_by_title' do
    it 'returns the first object found matching the string passed in' do
      expect(Play.find_or_create_by_title(@title)).to eql(@play)
    end

    it 'creates a new play object if nothing was found' do
      new_play = Play.find_or_create_by_title('Newest Play')
      expect(new_play).to_not eql(@play)
      expect(Play.find_or_create_by_title('Newest Play')).to eql(new_play)
    end
  end

  describe '.find_or_create_character' do
    it 'finds a character object and adds it to the characters array' do
      expect(@play.find_or_create_character('Nikola Tesla')).to eql(@character)
    end

    it 'creates a character object if none were found' do
      expect(@play.find_or_create_character('Elon Musk')).to_not eql(@character)
    end

    it 'adds the character object to the characters array' do
      character = @play.find_or_create_character('Elon Musk')
      expect(@play.characters.last).to eql(character)
    end
  end

  describe '.sorted_characters' do
    it 'sorts the characters array by character line count' do
      expect(@play.characters.sort_by { |char| char.lines_count }.reverse).to eql(@play.sorted_characters)
    end
  end

  describe '.output_lines_per_character' do
    it 'logs each characters line count and name' do
      @play.output_lines_per_character
      expect { @play.output_lines_per_character }.to output.to_stdout
      expect { @play.output_lines_per_character }.to output("0 Nikola Tesla\n").to_stdout
    end
  end

  xit 'prints line count and character name' do
    url = 'http://www.ibiblio.org/xml/examples/shakespeare/hamlet.xml'
    IbiblioXML.new(url).call
  end
end
