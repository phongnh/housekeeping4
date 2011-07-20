namespace :db do
  desc "Load the sample data from db/sample_data.rb"
  task :sample_data => :environment do
    file = File.join(Rails.root, 'db', 'sample_data.rb')
    load(file) if File.exist?(file)
  end
end

