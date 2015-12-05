class ImpQfTradesController < ApplicationController
  before_action :set_imp_qf_trade, only: [:show, :edit, :update, :destroy]

  # GET /imp_qf_trades
  # GET /imp_qf_trades.json
  def index
    @q = ImpQfTrade.ransack params[:q]
    @imp_qf_trades = @q.result(distinct: true).page(params[:page])

  end

  # GET /imp_qf_trades/1
  # GET /imp_qf_trades/1.json
  def show
  end

  # GET /imp_qf_trades/new
  def new
    @imp_qf_trade = ImpQfTrade.new
  end

  # GET /imp_qf_trades/1/edit
  def edit
  end

  # POST /imp_qf_trades
  # POST /imp_qf_trades.json
  def create
    @imp_qf_trade = ImpQfTrade.new(imp_qf_trade_params)

    respond_to do |format|
      if @imp_qf_trade.save
        format.html { redirect_to @imp_qf_trade, notice: 'Imp qf trade was successfully created.' }
        format.json { render :show, status: :created, location: @imp_qf_trade }
      else
        format.html { render :new }
        format.json { render json: @imp_qf_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imp_qf_trades/1
  # PATCH/PUT /imp_qf_trades/1.json
  def update
    respond_to do |format|
      if @imp_qf_trade.update(imp_qf_trade_params)
        format.html { redirect_to @imp_qf_trade, notice: 'Imp qf trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @imp_qf_trade }
      else
        format.html { render :edit }
        format.json { render json: @imp_qf_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imp_qf_trades/1
  # DELETE /imp_qf_trades/1.json
  def destroy
    @imp_qf_trade.destroy
    respond_to do |format|
      format.html { redirect_to imp_qf_trades_url, notice: 'Imp qf trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imp_qf_trade
      @imp_qf_trade = ImpQfTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imp_qf_trade_params
      params[:imp_qf_trade]
    end
end
