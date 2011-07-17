class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :category_type, :default => INCOMING

      t.timestamps
    end

    add_index :categories, :name, :unique => true
    add_index :categories, :category_type
  end

  def self.down
    drop_table :categories
  end
end

