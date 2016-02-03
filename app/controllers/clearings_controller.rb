class ClearingsController < ApplicationController
  before_action :set_clearing, only: [:show, :edit, :update, :destroy]

  # GET /clearings
  # GET /clearings.json
  def index
    @q = Clearing.ransack( params[:q] )
    @collection = @q.result().order("trade_date DESC").page( params[:page]).per(100)
  end

  # GET /clearings/1
  # GET /clearings/1.json
  def show
  end

  # GET /clearings/new
  def new
    @object = Clearing.new
  end

  # GET /clearings/1/edit
  def edit
  end

  # POST /clearings
  # POST /clearings.json
  def create
    @object = Clearing.new(clearing_params)

    respond_to do |format|
      if @object.save
        format.html { redirect_to @object, notice: 'Clearing was successfully created.' }
        format.json { render :show, status: :created, location: @object }
      else
        format.html { render :new }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clearings/1
  # PATCH/PUT /clearings/1.json
  def update
    respond_to do |format|
      if @object.update(clearing_params)
        format.html { redirect_to @object, notice: 'Clearing was successfully updated.' }
        format.json { render :show, status: :ok, location: @object }
      else
        format.html { render :edit }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clearings/1
  # DELETE /clearings/1.json
  def destroy
    @object.destroy
    respond_to do |format|
      format.html { redirect_to clearings_url, notice: 'Clearing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clearing
      @object = Clearing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clearing_params
      params.require(:clearing).permit(:trade_date, :trade_amount, :trade_fee, :clearing_amount, :clearing_status)
    end
end
