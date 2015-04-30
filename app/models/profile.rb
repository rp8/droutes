class Profile < ActiveRecord::Base
  attr_accessible :name, :phone, :address, :orders_per_page, :customers_per_page
  attr_accessor :accessible

  belongs_to :user

  before_validation :format_params

  validates_presence_of :phone, :address

  private
  def format_params
    self.phone = phone.gsub(/[^0-9]/,'') if phone
  end

  def mass_assignment_authorizer
    super + (accessible || [])
  end

end
