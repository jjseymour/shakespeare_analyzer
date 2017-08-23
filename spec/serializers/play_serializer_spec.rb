require 'rails_helper'

RSpec.describe PlaySerializer, :type => :serializer do
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

  describe '#serialize' do
    it 'hashes then stringifies the play object' do
      play_serializer = PlaySerializer.serialize(@play)
      expect(play_serializer).to be_a_kind_of(String)
      expect(play_serializer.first).to eql("{")
    end

    it 'stringifies the characters array with the characters serializer' do
      play_serializer = PlaySerializer.serialize(@play)
      expect(play_serializer).to include(CharacterSerializer.serialize(@character).to_json)
    end
  end
end
