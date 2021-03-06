class CustomersController < ApplicationController

  before_filter :authenticate_user!

  # GET /customers
  # GET /customers.xml
  def index
    @customers = Customer.search(current_user, params[:search]).paginate(:per_page => current_user.profile.customers_per_page, :page => params[:page]) 

    respond_to do |format|
      format.html # index.html.erb
      format.js   # index.js.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /customer/map
  def map
    respond_to do |format|
      format.js
    end
  end

  # GET /customers/map_all
  def map_all
    @customers = Customer.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /customers/duplicated
  def duplicated
    @customers = Customer.find_by_sql("SELECT id, name, phone, address, created_at FROM customers WHERE phone IN (SELECT distinct phone FROM customers GROUP BY phone HAVING COUNT(*) > 1) ORDER BY phone, created_at desc").paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html # deuplicated.html.erb
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = current_user.customers.find(params[:id], :include => :orders)
    @orders = @customer.orders.paginate(:per_page => current_user.profile.orders_per_page, :page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = current_user.customers.build

    respond_to do |format|
      format.html # new.html.erb
      format.js   # new.js.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = current_user.customers.find(params[:id])
  end

  # POST /customers
  # POST /customers.xml
  def create
    @customer = current_user.customers.build(params[:customer])

    respond_to do |format|
      if @customer.save 
        @customer.orders.create(:user_id => @customer.user.id, 
          :total => params[:total], :name => @customer.name, :phone => @customer.phone,
          :address => @customer.address, :instruction => params[:instruction]) if params[:order] == 'true'
        format.html { redirect_to(@customer, :notice => 'Customer was successfully created.') }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    @customer = current_user.customers.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        @customer.orders.create(:user_id => @customer.user.id, 
          :total => params[:total], :name => @customer.name, :phone => @customer.phone,
          :address => @customer.address, :instruction => params[:instruction]) if params[:order] == 'true'
        format.html { redirect_to(@customer, :notice => 'Customer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    if current_user.admin?
      @customer = Customer.find(params[:id])
    else
      @customer = current_user.customers.find(params[:id])
    end

    @customer.destroy

    respond_to do |format|
      format.html { 
        if params[:duplicated] == 'true'
          redirect_to customers_duplicated_url
        else
          redirect_to(customers_url) 
        end
      }
      format.xml  { head :ok }
    end
  end
end
