module RakeHelper
  def self.run_command_line(scraper)
    scraper.run
    scraper.output_play_lines_and_characters
  end
end
