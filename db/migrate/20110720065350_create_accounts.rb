class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :owner_id
      t.string :name
      t.boolean :default, :default => false
      t.string :description
      t.integer :earnings, :default => 0
      t.integer :expenses, :default => 0
      t.integer :balance, :default => 0

      t.timestamps
    end

    add_index :accounts, :owner_id
    add_index :accounts, :name
    add_index :accounts, [:owner_id, :name], :unique => true
  end

  def self.down
    drop_table :accounts
  end
end

