def create_sample_categories
  puts "-> Creating sample categories..."
  20.times do |i|
    log(i)
    Category.create :name => Faker::Company.catch_phrase
  end
end

def create_sample_users
  puts "-> Creating sample users..."
  10.times do |i|
    User.create :first_name            => Faker::Name.first_name,
                :last_name             => Faker::Name.last_name,
                :email                 => Faker::Internet.email,
                :password              => "123456",
                :password_confirmation => "123456"
  end
  puts "-> Finished."
end

def create_sample_accounts
  puts "-> Creating sample accounts..."
  users = User.all.collect(&:id)
  10.times do |i|
    Account.create :owner_id => users.sample,
                   :name => Faker::Company.name
  end
  puts "-> Finished."
end

def create_sample_transactions
  puts "-> Creating sample transactions..."
  categories = Category.all.collect(&:id)
  users      = User.all.collect(&:id)
  accounts   = Account.all.collect(&:id)
  types      = TransactionType.all.collect(&:id)
  days       = (-500..10).to_a
  1000.times do |i|
    Transaction.create :date        => Date.today + days.sample.day,
                       :account_id  => accounts.sample,
                       :owner_id    => users.sample,
                       :category_id => categories.sample,
                       :amount      => (rand * 1_000_000).to_i,
                       :description => Faker::Lorem.paragraph,
                       :kind        => types.sample
  end
  puts "-> Finished"
end

create_sample_categories
create_sample_users
create_sample_accounts
create_sample_transactions

