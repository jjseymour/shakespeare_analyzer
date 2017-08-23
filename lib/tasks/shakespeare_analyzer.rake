namespace :shakespeare do
  desc "output line count of macbeth characters"
  task :macbeth => :environment do
    ibiblio = IbiblioXML.new()
    RakeHelper.run_command_line(ibiblio)
  end

  desc "output line count of hamlet characters"
  task :hamlet => :environment do
    ibiblio = IbiblioXML.new('hamlet')
    RakeHelper.run_command_line(ibiblio)
  end

  desc "output line count of hamlet characters"
  task :any, [:play_name] => :environment do |t, args|
    ibiblio = IbiblioXML.new(args.play_name)
    RakeHelper.run_command_line(ibiblio)
  end

  desc "see a list of possible plays"
  task :list => :environment do
    IbiblioXML.list_plays
  end
end
