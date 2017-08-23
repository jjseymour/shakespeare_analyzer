require 'open-uri'

class IbiblioXML
  attr_reader :url, :doc, :xml, :play, :error

  DEFAULT_URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

  PLAYS = {
    "all'swellthatendswell": "all_well",
    "asyoulikeit": "as_you",
    "antonyandcleopatra": "a_and_c",
    "acomedyoferrors": "com_err",
    "coriolanus": "coriolan",
    "cymbelin": "cymbelin",
    "amidsummernight'sdream": "dream",
    "hamlet": "hamlet",
    "henryiv,parti": "hen_vi_1",
    "henryiv,partii": "hen_vi_2",
    "henryv": "hen_v",
    "henryviii": "hen_viii",
    "henryvii,part1": "hen_vi_1",
    "henryvii,part2": "hen_vi_2",
    "henryvii,part3": "hen_vi_3",
    "thelifeanddeathofkingjohn": "john",
    "juliuscaesar": "j_caesar",
    "kinglear": "lear",
    "love'slabor'slost": "lll",
    "macbeth": "macbeth",
    "themerchantofvenice": "merchant",
    "muchadoaboutnothing": "much_ado",
    "measureformeasure": "m_for_m",
    "themerrywivesofwindsor": "m_wives",
    "othello": "othello",
    "pericles": "pericles",
    "richardii": "rich_ii",
    "richardiii": "rich_iii",
    "romeoandjuliet": "r_and_j",
    "thetamingoftheshrew": "taming",
    "thetempest": "tempest",
    "timonofathens": "timon",
    "titusandronicus": "titus",
    "troilusandcressida": "troilus",
    "twogentlemenofverona": "two_gent",
    "twelfthnight": "t_night",
    "awinter'stale": "win_tale"
  }

  LIST_PLAYS = [
    "All's Well That Ends Well",
    "As You Like It",
    "Antony And Cleopatra",
    "A Comedy of Errors",
    "Coriolanus",
    "Cymbelin",
    "A Midsummer Night's Dream",
    "Hamlet",
    "Henry IV, Part I",
    "Henry IV, Part II",
    "Henry V",
    "Henry VIII",
    "Henry VII, Part 1",
    "Henry VII, Part 2",
    "Henry VII, Part 3",
    "The Life and Death of King John",
    "Julius Caesar",
    "King Lear",
    "Love's Labor's Lost",
    "Macbeth",
    "The Merchant of Venice",
    "Much Ado About Nothing",
    "Measure for Measure",
    "The Merry Wives of Windsor",
    "Othello",
    "Pericles",
    "Richard II",
    "Richard III",
    "Romeo and Juliet",
    "The Taming of The Shrew",
    "The Tempest",
    "Timon of Athens",
    "Titus Andronicus",
    "Troilus and Cressida",
    "Two Gentlemen of Verona",
    "Twelfth Night",
    "A Winter's Tale"
  ]

  def self.list_plays
    puts LIST_PLAYS
  end

  def initialize(url=DEFAULT_URL)
    url = DEFAULT_URL if url.empty?
    @url = parse_url(url)
  end

  def run
    fetch
    return self if error
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
      @error = e.message
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
        if child.text == 'ALL' || child.text == 'All' || child.text.empty?
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
    naturalize_url = url.downcase.gsub(/\s+/, "")
    if PLAYS.has_key?(naturalize_url.to_sym)
      "http://www.ibiblio.org/xml/examples/shakespeare/#{PLAYS[naturalize_url.to_sym]}.xml"
    else
      "http://www.ibiblio.org/xml/examples/shakespeare/#{naturalize_url}.xml"
    end
  end
end
