# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Begin creating seed data..."

puts "-> Creating categories..."
Category.seed
puts "-> Finished."

puts "-> Creating transaction types..."
TransactionType.seed
puts "-> Finished."

puts "-> Creating account types..."
AccountType.seed
puts "-> Finished."

puts "-> Creating administrator of system..."
User.seed
puts "-> Finished."

puts "Finished creating seed data."
