class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :initialize_session #create empty cart array, if not already initialized
  before_action :load_cart_variable

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def add_to_cart
    prod_key = params[:id] # is of datatype string

    if session[:cart].keys.include?(prod_key)
      session[:cart][prod_key] += 1
    else
      session[:cart][prod_key] = 1
    end

    # prevent rails from trying to load up a view of the same name as the action
    redirect_to products_path
  end

  def remove_from_cart
    prod_key = params[:id]
    session[:cart].delete(prod_key)

    redirect_to products_path
  end

  def decrement_from_cart
    prod_key = params[:id]

    if session[:cart][prod_key] == 1
      session[:cart].delete(prod_key)
    else
      session[:cart][prod_key] -= 1
    end

    redirect_to products_path
  end

  def clear_cart
    session[:cart] = Hash.new
    redirect_to products_path
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def initialize_session
      session[:cart] ||= Hash.new
    end

    def load_cart_variable
      # loads a set of objects from the db
      @cart_contents = Product.find(session[:cart].keys)
      @cart_subtotal = 0

      session[:cart].each do |prod_id,qty|
        price = Product.find(prod_id.to_i).price
        @cart_subtotal += (price*qty)/100.0
      end
    end

end
