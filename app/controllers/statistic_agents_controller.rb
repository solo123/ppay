class StatisticAgentsController < ApplicationController
  before_action :set_statistic_agent, only: [:show, :edit, :update, :destroy]

  # GET /statistic_agents
  # GET /statistic_agents.json
  def index
    @statistic_agents = StatisticAgent.all
  end

  # GET /statistic_agents/1
  # GET /statistic_agents/1.json
  def show
  end

  # GET /statistic_agents/new
  def new
    @statistic_agent = StatisticAgent.new
  end

  # GET /statistic_agents/1/edit
  def edit
  end

  # POST /statistic_agents
  # POST /statistic_agents.json
  def create
    @statistic_agent = StatisticAgent.new(statistic_agent_params)

    respond_to do |format|
      if @statistic_agent.save
        format.html { redirect_to @statistic_agent, notice: 'Statistic agent was successfully created.' }
        format.json { render :show, status: :created, location: @statistic_agent }
      else
        format.html { render :new }
        format.json { render json: @statistic_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistic_agents/1
  # PATCH/PUT /statistic_agents/1.json
  def update
    respond_to do |format|
      if @statistic_agent.update(statistic_agent_params)
        format.html { redirect_to @statistic_agent, notice: 'Statistic agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @statistic_agent }
      else
        format.html { render :edit }
        format.json { render json: @statistic_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistic_agents/1
  # DELETE /statistic_agents/1.json
  def destroy
    @statistic_agent.destroy
    respond_to do |format|
      format.html { redirect_to statistic_agents_url, notice: 'Statistic agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statistic_agent
      @statistic_agent = StatisticAgent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statistic_agent_params
      params[:statistic_agent]
    end
end
