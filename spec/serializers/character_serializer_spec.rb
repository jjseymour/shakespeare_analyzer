require 'rails_helper'

RSpec.describe PlaySerializer, :type => :serializer do
  before(:each) do
    @title = "I wrote something!"
    @play = Play.new(@title)
    @character = Character.new('Nikola Tesla', @play)
    @line = Line.new('Something witty!', @character)
  end

  after(:each) do
    @play.characters.clear
    Play.class_variable_get(:@@all).clear
    @character.lines.clear
    Character.class_variable_get(:@@all).clear
  end

  describe '#serialize' do
    it 'hashes then stringifies the character object' do
      character_serializer = CharacterSerializer.serialize(@character)
      expect(character_serializer).to be_a_kind_of(String)
      expect(character_serializer.first).to eql("{")
    end

    it 'stringifies the lines as the line count' do
      character_serializer = CharacterSerializer.serialize(@character)
      expect(character_serializer).to include({name:"Nikola Tesla", lines:0}.to_json)
      @character.add_line('Something Wittier!')
      character_serializer = CharacterSerializer.serialize(@character)
      expect(character_serializer).to include({name:"Nikola Tesla", lines:1}.to_json)
    end
  end
end
