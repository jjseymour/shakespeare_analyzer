require 'rails_helper'

RSpec.describe Line, :type => :model do

  it 'initializes with content and a character' do
    line = Line.new("I am new here")
    expect(line.content)
  end
end
