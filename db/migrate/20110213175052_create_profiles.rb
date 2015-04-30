class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id, :null => false
      t.string :phone, :limit => 15
      t.string :address, :limit => 100
      t.integer :orders_per_page, :default => 10
      t.integer :customers_per_page, :default => 5

      t.timestamps
    end

    add_index :profiles, :user_id, :name => "index_profiles_on_user_id", :unique => true
    #remove_column :users, :orders_per_page
    #remove_column :users, :customers_per_page
    #remove_column :users, :phone
    #remove_column :users, :address
  end

  def self.down
    drop_table :profiles
    remove_index :profiles, :user_id
    #add_column :users, :orders_per_page
    #add_column :users, :customers_per_page
    #add_column :users, :phone
    #add_column :users, :address
  end
end
