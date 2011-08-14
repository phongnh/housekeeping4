class CreateAccountTypes < ActiveRecord::Migration
  def self.up
    create_table :account_types do |t|
      t.string :names
    end

    add_index :account_types, :names, :unique => true
  end

  def self.down
    drop_table :account_types
  end
end
