class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :color, :default => "white"
      t.integer :parent_id

      t.timestamps
    end

    add_index :categories, :name, :unique => true
    add_index :categories, :parent_id
  end

  def self.down
    drop_table :categories
  end
end

