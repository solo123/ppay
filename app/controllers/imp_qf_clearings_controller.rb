class ImpQfClearingsController < ApplicationController
  before_action :set_imp_qf_clearing, only: [:show, :edit, :update, :destroy]

  # GET /imp_qf_clearings
  # GET /imp_qf_clearings.json
  def index
    @q = ImpQfClearing.ransack(params[:q])
    @imp_qf_clearings = @q.result(distinct: true).page(params[:page])
  end

  # GET /imp_qf_clearings/1
  # GET /imp_qf_clearings/1.json
  def show
  end

  # GET /imp_qf_clearings/new
  def new
    @imp_qf_clearing = ImpQfClearing.new
  end

  # GET /imp_qf_clearings/1/edit
  def edit
  end

  # POST /imp_qf_clearings
  # POST /imp_qf_clearings.json
  def create
    @imp_qf_clearing = ImpQfClearing.new(imp_qf_clearing_params)

    respond_to do |format|
      if @imp_qf_clearing.save
        format.html { redirect_to @imp_qf_clearing, notice: 'Imp qf clearing was successfully created.' }
        format.json { render :show, status: :created, location: @imp_qf_clearing }
      else
        format.html { render :new }
        format.json { render json: @imp_qf_clearing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imp_qf_clearings/1
  # PATCH/PUT /imp_qf_clearings/1.json
  def update
    respond_to do |format|
      if @imp_qf_clearing.update(imp_qf_clearing_params)
        format.html { redirect_to @imp_qf_clearing, notice: 'Imp qf clearing was successfully updated.' }
        format.json { render :show, status: :ok, location: @imp_qf_clearing }
      else
        format.html { render :edit }
        format.json { render json: @imp_qf_clearing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imp_qf_clearings/1
  # DELETE /imp_qf_clearings/1.json
  def destroy
    @imp_qf_clearing.destroy
    respond_to do |format|
      format.html { redirect_to imp_qf_clearings_url, notice: 'Imp qf clearing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imp_qf_clearing
      @imp_qf_clearing = ImpQfClearing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imp_qf_clearing_params
      params[:imp_qf_clearing]
    end
end
