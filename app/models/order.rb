class Order < ActiveRecord::Base
  belongs_to :customer

  scope :recent, Order.order('created_at desc')

  def self.search(user, customer_id)
    if customer_id
      where('user_id = ? and customer_id = ?', user.id, "#{customer_id}%").order('orders.order_status desc, orders.created_at desc')
    else
      where('user_id = ?', user.id).order('orders.order_status desc, orders.created_at desc')
    end
  end
end
