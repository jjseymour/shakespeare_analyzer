require 'rails_helper'

RSpec.describe IbiblioXML, :type => :adapter do
  before(:each) do
    @url = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
    @xml_call = IbiblioXML.new(@url)
  end

  it 'initializes with one argument for a URL' do
    expect(@xml_call.url).to include(@url)
  end

  it 'parses argument into URL based on different inputs' do
    single_arg = IbiblioXML.new('hamlet')
    url = 'http://www.ibiblio.org/xml/examples/shakespeare/hamlet.xml'
    no_arg = IbiblioXML.new()

    expect(@xml_call.url).to include(@url)
    expect(single_arg.url).to include(url)
    expect(no_arg.url).to include(@url)
  end

end
