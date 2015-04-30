class OrdersController < ApplicationController

  before_filter :authenticate_user!

  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.search(current_user, params[:customer_id]).paginate(:per_page => current_user.profile.orders_per_page, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js   # index.js.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = current_user.orders.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js   # show.js.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/direction
  def direction
    @order = current_user.orders.find(params[:order_id])

    respond_to do |format|
      format.html { render :layout => 'map' }
      format.js
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @customer = current_user.customers.find(params[:customer_id])
    @order = current_user.orders.build(:name => @customer.name, 
      :phone => @customer.phone, :address => @customer.address, 
      :instruction => @customer.note,
      :customer_id => params[:customer_id], :total => 0.00)

    respond_to do |format|
      format.html # new.html.erb
      format.js   # new.js.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = current_user.orders.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js   # edit.js.erb
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = current_user.orders.build(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.js {
          @orders = Order.search(current_user, nil).paginate(:per_page => current_user.profile.orders_per_page, :page => params[:page])
        } # create.js.erb
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = current_user.orders.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.js { 
          @orders = Order.search(current_user, nil).paginate(:per_page => current_user.profile.orders_per_page, :page => params[:page])
        }  # update.js.erb
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1/toggle
  def toggle
    @order = current_user.orders.find(params[:order_id])

    respond_to do |format|
      if @order.update_attribute(:order_status, @order.order_status == 'NEW' ? 'DONE' : 'NEW')
        format.js # toggle_status.js.erb
      else
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = current_user.orders.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to("/customers/#{@order.customer.id}") }
      format.xml  { head :ok }
    end
  end
end
