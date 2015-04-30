class AddNameToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :name, :string, :limit => 50
  end

  def self.down
    remove_column :profiles, :name
  end
end
