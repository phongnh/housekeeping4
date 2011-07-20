class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.date :date
      t.integer :account_id
      t.integer :category_id
      t.integer :owner_id
      t.integer :amount
      t.string :description
      t.integer :kind, :default => INCOMING
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :transactions, :date
    add_index :transactions, :account_id
    add_index :transactions, :category_id
    add_index :transactions, :owner_id
    add_index :transactions, :kind
  end

  def self.down
    drop_table :transactions
  end
end
