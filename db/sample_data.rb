def create_sample_transactions
  puts "-> Creating sample transactions..."
  categories = Category.root.collect(&:id)
  u = User.first
  a = u.accounts.default.first
  t = TYPES.keys
  200.times do
    Transaction.create :date        => Date.today,
                       :account_id  => a.id,
                       :owner_id    => u.id,
                       :category_id => categories.sample,
                       :amount      => (rand * 10_000_000).to_i,
                       :kind        => t.sample
  end
end

create_sample_transactions

