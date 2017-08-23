require 'rails_helper'

RSpec.describe Play, :type => :model do
  it 'prints line count and character name' do
    url = 'http://www.ibiblio.org/xml/examples/shakespeare/hamlet.xml'
    IbiblioXML.new(url).call
  end
end
