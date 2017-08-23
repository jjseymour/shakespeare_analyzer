require 'rails_helper'

RSpec.describe Character, :type => :model do
  before(:each) do
    @name = "First Witch"
  end

  it 'initializes with a name and empty array for lines' do
    character = Character.new(@name)
    expect(character.name).to include(@name)
    expect(character.lines).to be_empty
  end
end
