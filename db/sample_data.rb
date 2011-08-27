def create_sample_categories(count=10)
  puts "-> Creating sample categories..."
  count.times do |i|
    Category.create :name => Faker::Company.catch_phrase
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
  end
  puts "-> Finished."
end

def create_sample_accounts(count=10)
  puts "-> Creating sample accounts..."
  users = User.select(:id).collect(&:id)
  types = AccountType.select(:id).collect(&:id)
  count.times do |i|
    Account.create :owner_id => users.sample,
                   :name => Faker::Company.name,
                   :account_type_id => types.sample
  end
  puts "-> Finished."
end

def create_sample_transactions(count=1000)
  puts "-> Creating sample transactions..."
  categories = Category.select(:id).collect(&:id)
  users      = User.select(:id).collect(&:id)
  accounts   = Account.select(:id).collect(&:id)
  types      = TransactionType.select(:id).collect(&:id)
  days       = (-500..10).to_a
  count.times do |i|
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

