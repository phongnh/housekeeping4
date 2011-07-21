def create_sample_transactions
  puts "-> Creating sample transactions..."
  categories = Category.root.collect(&:id)
  u = User.first
  a = u.accounts.default.first
  t = TYPES.keys
  d = (-10..10).to_a
  200.times do |i|
    puts "   Adding line \##{i+1}..."
    Transaction.create :date        => Date.today + d.sample.day,
                       :account_id  => a.id,
                       :owner_id    => u.id,
                       :category_id => categories.sample,
                       :amount      => (rand * 1_000_000).to_i,
                       :kind        => t.sample
  end
end

create_sample_transactions

