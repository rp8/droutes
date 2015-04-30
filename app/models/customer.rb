class Customer < ActiveRecord::Base
  belongs_to :user
  has_many :orders, :order => 'updated_at desc', :dependent => :delete_all

  scope :recent, (joins(:orders) & Order.order('created_at desc')).select("distinct customers.*")

  before_validation :format_params

  validates_presence_of :phone, :address
  validates_uniqueness_of :phone

  def self.search(user, phone)
    if phone
      where('customers.user_id = ? and phone LIKE ?', user.id, "%#{phone.gsub(/[^0-9]/,'')}%")
    else
      recent.where('customers.user_id = ?', user.id)
    end
  end

  def format_params
    self.phone = phone.gsub(/[^0-9]/,'')
  end

end
