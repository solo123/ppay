class StatisticTradesController < ApplicationController
  before_action :set_statistic_trade, only: [:show, :edit, :update, :destroy]

  # GET /statistic_trades
  # GET /statistic_trades.json
  def index
    @statistic_trades = StatisticTrade.all
  end

  # GET /statistic_trades/1
  # GET /statistic_trades/1.json
  def show
  end

  # GET /statistic_trades/new
  def new
    @statistic_trade = StatisticTrade.new
  end

  # GET /statistic_trades/1/edit
  def edit
  end

  # POST /statistic_trades
  # POST /statistic_trades.json
  def create
    @statistic_trade = StatisticTrade.new(statistic_trade_params)

    respond_to do |format|
      if @statistic_trade.save
        format.html { redirect_to @statistic_trade, notice: 'Statistic trade was successfully created.' }
        format.json { render :show, status: :created, location: @statistic_trade }
      else
        format.html { render :new }
        format.json { render json: @statistic_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistic_trades/1
  # PATCH/PUT /statistic_trades/1.json
  def update
    respond_to do |format|
      if @statistic_trade.update(statistic_trade_params)
        format.html { redirect_to @statistic_trade, notice: 'Statistic trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @statistic_trade }
      else
        format.html { render :edit }
        format.json { render json: @statistic_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistic_trades/1
  # DELETE /statistic_trades/1.json
  def destroy
    @statistic_trade.destroy
    respond_to do |format|
      format.html { redirect_to statistic_trades_url, notice: 'Statistic trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statistic_trade
      @statistic_trade = StatisticTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statistic_trade_params
      params[:statistic_trade]
    end
end
