class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # manage salesman
  def add_salesman
    set_agent
    @agent.salesmen << Salesman.find(params[:salesman_id])
    redirect_to @agent
  end
  def del_salesman
    set_agent
    s = Salesman.find(params[:salesman_id])
    s.agent = nil
    s.save
    redirect_to @agent
  end

  # GET /agents
  # GET /agents.json
  def index
    @agents = Agent.page(params[:page])
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    @client_count = @agent.clients.count
    @trade_amount_sum = @agent.trades.sum('trade_amount')

    if @agent.clients.count > 0
      dif_date = DateTime.current - @agent.clients.first.join_date.to_datetime
      @join_days = dif_date.to_i.to_s
      @last_date = @agent.clients.last.join_date.to_datetime
    end


  end

  # GET /agents/new
  def new
    @agent = Agent.new
    2.times {@agent.bank_cards.build}
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new()

    respond_to do |format|
      if @agent.save
        format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
        format.json { render :show, status: :created, location: @agent }
      else
        format.html { render :new }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @agent }
      else
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'Agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
      2.times {@agent.bank_cards.build}

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(
        :name, :mobile, :cooperation_date, :cooperation_type_id,
        :cooperation_date, :t0_enabled, :bank_biz_types,
        :cooperation_location, :deposit, :amounts_payable,
        :bank_cards, :company
      )
    end
end
