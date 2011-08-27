# Faker doesn't support vietnamese locale yet
Faker::Config.locale = :en

namespace :db do
  namespace :sample do
    desc "Create all sample data"
    task :all => :environment do
      file = File.join(Rails.root, 'db', 'sample_data.rb')
      load file
      create_sample_categories
      create_sample_users
      create_sample_accounts
      create_sample_transactions
    end

    desc "Create sample accounts"
    task :accounts, :num, :needs => :environment do |t, args|
      args.with_defaults :num => 10
      file = File.join(Rails.root, 'db', 'sample_data.rb')
      load file
      create_sample_accounts args[:num].to_i
    end

  end
end

