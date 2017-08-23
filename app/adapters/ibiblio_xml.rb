require 'open-uri'
class IbiblioXML
  attr_reader :url, :doc, :xml, :play
  URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

  def initialize(url=URL)
    url = URL if url.empty?
    @url = parse_url(url)
  end

  def run
    error_check = fetch
    return error_check if error_check.is_a?(Hash)
    parse_xml
    create_play
    create_characters if play.characters.empty?
    sort_characters_by_lines
    play
  end

  def output_play_lines_and_characters
    play.output_lines_per_character
  end

  private

  def fetch
    begin
      @xml = open(url)
    rescue Exception => e
      return {
        errors: e.message
      }
    end
  end

  def parse_xml
    @doc = Nokogiri::XML(xml)
  end

  def create_play
    @play = Play.find_or_create_by_title(doc.xpath("//TITLE")[0].text)
  end

  def create_characters
    doc.xpath("//SPEECH").each do |speech|
      character = nil
      speech.children.each do |child|
        if child.text == 'ALL' || child.text == 'All'
          break
        elsif child.name == 'SPEAKER'
          character = play.find_or_create_character(parse_name(child.text))
        elsif child.name == 'LINE'
          character.add_line(child.text)
        end
      end
    end
  end

  def parse_name(name)
    name.split.map { |n| n.downcase.capitalize }.join(" ")
  end

  def sort_characters_by_lines
    play.sorted_characters
  end

  def parse_url(url)
    return url if url.include?('www.ibiblio.org')
    "http://www.ibiblio.org/xml/examples/shakespeare/#{url}.xml"
  end
end
