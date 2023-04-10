class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show edit update destroy ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: "#{@customer.name}, thank you for creating an account."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    redirect_to customers_url, notice: "Customer was successfully destroyed."
  end

  def login
  end

  def authenticate
    customer = Customer.find_by(username: params[:username])
    if customer.present?
    # if customer.present? && customer.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to root_path, notice: "Logged in"
    else
      flash[:alert] = "Invalid email or password."
      render :login
    end
  end

  def logout
    session[:customer_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:name, :username, :password, :address, :province_id)
    end
end
