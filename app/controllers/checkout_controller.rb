class CheckoutController < ApplicationController
  before_action :initialize_session
  before_action :load_cart_variable
  before_action :get_customer
  before_action :calculate_taxes

  def index
  end

  def thankyou
    @order = Order.last
    @order_products = OrderProduct.where(order_id: @order.id)
  end

  private
    def initialize_session
      session[:cart] ||= Hash.new
    end

    def load_cart_variable
      @cart_contents = Product.find(session[:cart].keys)
      @cart_subtotal = 0

      session[:cart].each do |prod_id,qty|
        price = Product.find(prod_id.to_i).price
        @cart_subtotal += (price*qty)/100.0
      end
    end

    def get_customer
      @customer = Customer.find_by(id: session[:customer_id])
    end

    def calculate_taxes
      # @customer = Customer.find_by(id: session[:customer_id])
      unless @customer.nil?
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
