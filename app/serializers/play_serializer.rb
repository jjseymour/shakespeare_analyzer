class PlaySerializer
  def self.serialize(play)
    @play = play
    {
      title: @play.title,
      characters: serialize_characters
    }.to_json
  end

  def self.serialize_characters
    @play.characters.map { |character| CharacterSerializer.serialize(character) }
  end
end
