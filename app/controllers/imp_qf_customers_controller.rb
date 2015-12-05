class ImpQfCustomersController < ApplicationController
  before_action :set_imp_qf_customer, only: [:show, :edit, :update, :destroy]

  # GET /imp_qf_customers
  # GET /imp_qf_customers.json
  def index
    @q = ImpQfCustomer.ransack(params[:q])
    @imp_qf_customers = @q.result(distinct: true).page(params[:page])
  end

  # GET /imp_qf_customers/1
  # GET /imp_qf_customers/1.json
  def show
  end


  # GET /imp_qf_customers/new
  def new
    @imp_qf_customer = ImpQfCustomer.new
  end

  # GET /imp_qf_customers/1/edit
  def edit
  end

  # POST /imp_qf_customers
  # POST /imp_qf_customers.json
  def create
    @imp_qf_customer = ImpQfCustomer.new(imp_qf_customer_params)

    respond_to do |format|
      if @imp_qf_customer.save
        format.html { redirect_to @imp_qf_customer, notice: 'Imp qf customer was successfully created.' }
        format.json { render :show, status: :created, location: @imp_qf_customer }
      else
        format.html { render :new }
        format.json { render json: @imp_qf_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imp_qf_customers/1
  # PATCH/PUT /imp_qf_customers/1.json
  def update
    respond_to do |format|
      if @imp_qf_customer.update(imp_qf_customer_params)
        format.html { redirect_to @imp_qf_customer, notice: 'Imp qf customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @imp_qf_customer }
      else
        format.html { render :edit }
        format.json { render json: @imp_qf_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imp_qf_customers/1
  # DELETE /imp_qf_customers/1.json
  def destroy
    @imp_qf_customer.destroy
    respond_to do |format|
      format.html { redirect_to imp_qf_customers_url, notice: 'Imp qf customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imp_qf_customer
      @imp_qf_customer = ImpQfCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imp_qf_customer_params
      params[:imp_qf_customer]
    end
end
