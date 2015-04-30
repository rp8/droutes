class AdminController < ApplicationController
  before_filter :authenticate_user!, :admin!

  layout 'admin'

  # GET /admin/index
  def index
    @users = User.all.paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end

  end

  # GET /users/1
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end

  end

  # GET /users/1/orders
  def list_orders
    @orders = Order.recent.where('orders.user_id = ?', params[:id]).paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # list_orders.html.erb
      format.js   # list_orders.js.erb
    end
  end

  # GET /users/1/customers
  def list_customers
    @customers = Customer.recent.where('customers.user_id = ?', params[:id]).paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # list_customers.html.erb
      format.js   # list_customers.js.erb
    end
  end

  protected
  def admin!
    unless current_user.admin?
      redirect_to '/customers'
      return false
    end
  end

end
