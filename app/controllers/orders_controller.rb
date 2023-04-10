class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

      if @order.save
        redirect_to order_url(@order), notice: "Order was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
      if @order.update(order_params)
        redirect_to order_url(@order), notice: "Order was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

      redirect_to orders_url, notice: "Order was successfully destroyed."
      head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer_id, :payment_id, :status)
    end
end
