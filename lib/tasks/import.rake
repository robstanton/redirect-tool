require 'csv'



  desc "Import CSV Data"
  task :import_stuff => :environment do

    csv_file_path = 'db/redirectsToLoad.csv'

    CSV.foreach(csv_file_path) do |row|
      Redirect.create!({
        :source => row[0],
        :target => row[1],
        :changedby => row[2],
        :published => row[3],         
      })
      puts "Row added!"
    end
  end
