class SalesCommissionsController < ApplicationController
  before_action :set_sales_commission, only: [:show, :edit, :update, :destroy]


  def agents
    @sales_commissions = SalesCommission.where("sales_commission_obj_id": params[:q])

  end
  # GET /sales_commissions
  # GET /sales_commissions.json
  def index
    @sales_commissions = SalesCommission.all
  end

  # GET /sales_commissions/1
  # GET /sales_commissions/1.json
  def show
  end

  # GET /sales_commissions/new
  def new
    @sales_commission = SalesCommission.new(sales_commission_obj_id: params[:q])
  end

  # GET /sales_commissions/1/edit
  def edit
  end

  # POST /sales_commissions
  # POST /sales_commissions.json
  def create
    @sales_commission = SalesCommission.new(sales_commission_params)

    respond_to do |format|
      if @sales_commission.save
        format.html { redirect_to @sales_commission, notice: 'Sales commission was successfully created.' }
        format.json { render :show, status: :created, location: @sales_commission }
      else
        format.html { render :new }
        format.json { render json: @sales_commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_commissions/1
  # PATCH/PUT /sales_commissions/1.json
  def update
    respond_to do |format|
      if @sales_commission.update(sales_commission_params)
        format.html { redirect_to @sales_commission, notice: 'Sales commission was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_commission }
      else
        format.html { render :edit }
        format.json { render json: @sales_commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_commissions/1
  # DELETE /sales_commissions/1.json
  def destroy
    @sales_commission.destroy
    respond_to do |format|
      format.html { redirect_to sales_commissions_url, notice: 'Sales commission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_commission
      @sales_commission = SalesCommission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_commission_params
      params.require(:sales_commission).permit(:sales_type, :count, :percent)
    end
end
