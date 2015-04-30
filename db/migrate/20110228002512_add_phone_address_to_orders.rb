class AddPhoneAddressToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :phone, :string, :size => 15
    add_column :orders, :name, :string, :size => 50
    add_column :orders, :address, :string, :size => 100
  end

  def self.down
    remove_column :orders, :address
    remove_column :orders, :name
    remove_column :orders, :phone
  end
end
