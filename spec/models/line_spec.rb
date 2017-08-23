require 'rails_helper'

RSpec.describe Line, :type => :model do
  before(:each) do
    @play = Play.new("A new play")
    @character = Character.new("Someone", @play)
    @content = "I am new here"
    @line = Line.new(@content, @character)
  end

  after(:each) do
    @play.characters.clear
    Play.class_variable_get(:@@all).clear
    @character.lines.clear
    Character.class_variable_get(:@@all).clear
  end

  describe 'initialize' do
    it 'initializes with content and a character' do
      expect(@line.instance_variable_get(:@content)).to equal(@content)
      expect(@line.instance_variable_get(:@character)).to equal(@character)
    end
  end

  describe '#all' do
    it 'returns the `all` class variable' do
      expect(Line.all).to equal(Line.class_variable_get(:@@all))
    end
  end
end
