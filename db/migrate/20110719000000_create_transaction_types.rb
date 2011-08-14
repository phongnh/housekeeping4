class CreateTransactionTypes < ActiveRecord::Migration
  def self.up
    create_table :transaction_types do |t|
      t.string :name
    end

    add_index :transaction_types, :name, :unique => true
  end

  def self.down
    drop_table :transaction_types
  end
end
