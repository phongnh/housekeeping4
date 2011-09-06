def create_sample_categories(count=10)
  puts "-> Creating sample categories..."
  count.times do |i|
    Category.create :name => Faker::Company.catch_phrase
    puts "Num: ##{i+1}"
  end
end

def create_sample_users(count=10)
  puts "-> Creating sample users..."
  count.times do |i|
    User.create :first_name            => Faker::Name.first_name,
                :last_name             => Faker::Name.last_name,
                :email                 => Faker::Internet.email,
                :password              => "123456",
                :password_confirmation => "123456"
    puts "Num: ##{i+1}"
  end
  puts "-> Finished."
end

def create_sample_accounts(count=10)
  puts "-> Creating sample accounts..."
  types = AccountType.select(:id).map(&:id)
  users = User.select(:id).map(&:id)
  count.times do |i|
    Account.create :owner_id => users.sample,
                   :name => Faker::Company.name,
                   :account_type_id => types.sample
    puts "Num: ##{i+1}"
  end
  puts "-> Finished."
end

def create_sample_transactions(count=1000)
  puts "-> Creating sample transactions..."
  categories = Category.select(:id).map(&:id)
  users      = User.select(:id).map(&:id)
  accounts   = Account.select(:id).map(&:id)
  types      = NORMAL_TYPES.keys
  days       = (-500..10).to_a
  count.times do |i|
    Transaction.save_and_update_account!(
      :date        => Date.today + days.sample.day,
      :account_id  => accounts.sample,
      :reporter_id => users.sample,
      :category_id => categories.sample,
      :amount      => (rand * 1_000_000).to_i,
      #:description => Faker::Lorem.paragraph,
      :kind        => types.sample
    )
    puts "Num: ##{i+1}"
  end
  puts "-> Finished"
end

