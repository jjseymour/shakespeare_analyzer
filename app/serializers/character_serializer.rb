class CharacterSerializer
  def self.serialize(character)
    @character = character
    {
      name: @character.name,
      lines: @character.lines_count
    }.to_json
  end
end
