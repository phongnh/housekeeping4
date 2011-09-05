class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.date :date
      t.integer :year,  :limit => 2
      t.integer :month, :limit => 1
      t.integer :day,   :limit => 1
      t.integer :account_id
      t.integer :category_id
      t.integer :reporter_id
      t.integer :payee_id
      t.integer :amount
      t.string :description
      t.integer :kind
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :transactions, :date
    add_index :transactions, :year
    add_index :transactions, :month
    add_index :transactions, :day
    add_index :transactions, [:year, :month]
    add_index :transactions, [:year, :month, :day]
    add_index :transactions, :account_id
    add_index :transactions, :category_id
    add_index :transactions, :reporter_id
    add_index :transactions, :payee_id
    add_index :transactions, :kind
  end

  def self.down
    drop_table :transactions
  end
end

