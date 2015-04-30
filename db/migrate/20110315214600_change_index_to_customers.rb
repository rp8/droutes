class ChangeIndexToCustomers < ActiveRecord::Migration
  def self.up
    remove_index "customers", :name => "customers_phone_unique"
    add_index "customers", ["user_id", "phone"], :name => "customers_user_id_phone_unique", :unique => true
  end

  def self.down
    add_index "customers", ["phone"], :name => "customers_phone_unique", :unique => true
  end
end
