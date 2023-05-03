class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :load_cart_variable
  before_action :get_customer
  before_action :calculate_taxes

  def invoice
    @customer = Customer.find(session[:customer_id])

    # generate a new order entry
    @order = Order.new(
      customer_id: @customer.id,
      payment_id: rand(111111..999999),
      status: "Pending",
      GST: @customer.province.GST,
      PST: @customer.province.PST,
      HST: @customer.province.HST
    )

    # loop through all the cart items and genereate OrderProduct entries
    if @order.save
      session[:cart].each do | prod_id, qty |
        new_order_prod = OrderProduct.new(
          order_id: @order.id,
          product_id: prod_id,
          qty: qty,
          price: Product.find(prod_id.to_i).price
        )
        new_order_prod.save

        # save the cart in picklist
        @picklist = session[:cart].clone

        # get the products in the cart
        @picklist_products = Product.find(@picklist.keys)

        # empty the cart
        session[:cart] = nil

        redirect_to thankyou_path
      end
    else
      redirect_to root_path, notice: "CANNOT SAVE ORDER."
    end

  end

  # GET /orders or /orders.json
  def index
    @orders = Order.all.reverse
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order_products = OrderProduct.where(order_id: @order.id)
  end

  # GET /orders/new
  def new
    @order = Order.new
    @province = Province.all
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    # create new order with the params in the form
    @order = Order.new(order_params)

    # loop through the cart items and save to OrderProducts
    if @order.save
      session[:cart].each do | prod_id, qty |
        new_order_prod = OrderProduct.new(
          order_id: @order.id,
          product_id: prod_id,
          qty: qty,
          price: Product.find(prod_id.to_i).price
        )
      new_order_prod.save
      end

      # empty the cart
      session[:cart] = nil
      redirect_to order_url(@order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    if @order.update(order_params)
      redirect_to orders_path, notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    redirect_to orders_path, notice: "Order was successfully destroyed."
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer_id, :payment_id, :status, :GST, :PST, :HST)
    end

    def initialize_session
      session[:cart] ||= Hash.new
    end

    def load_cart_variable
      unless session[:cart].blank?
        @cart = session[:cart]
        @cart_contents = Product.find(session[:cart].keys)
        @cart_subtotal = 0

        session[:cart].each do |prod_id,qty|
          price = Product.find(prod_id.to_i).price
          @cart_subtotal += (price*qty)/100.0
        end

      end
    end

    def get_customer
      @customer = Customer.find_by(id: session[:customer_id])
    end

    def calculate_taxes
      # @customer = Customer.find_by(id: session[:customer_id])
      unless @customer.nil? || session[:cart].blank?
        @taxes = {  "GST" => @customer.province.GST,
                    "PST" => @customer.province.PST,
                    "HST" => @customer.province.HST
                  }
        @GST_due = (@customer.province.GST)*(@cart_subtotal)/100.0
        @PST_due = (@customer.province.PST)*(@cart_subtotal)/100.0
        @HST_due = (@customer.province.HST)*(@cart_subtotal)/100.0

        @total_tax_amount = @GST_due + @PST_due + @HST_due
        @cart_grandtotal = (@cart_subtotal + @total_tax_amount)
      end
    end
  end

