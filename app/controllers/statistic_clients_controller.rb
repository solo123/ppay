class StatisticClientsController < ApplicationController
  before_action :set_statistic_client, only: [:show, :edit, :update, :destroy]

  # GET /statistic_clients
  # GET /statistic_clients.json
  def index
    @statistic_clients = StatisticClient.all
  end

  # GET /statistic_clients/1
  # GET /statistic_clients/1.json
  def show
  end

  # GET /statistic_clients/new
  def new
    @statistic_client = StatisticClient.new
  end

  # GET /statistic_clients/1/edit
  def edit
  end

  # POST /statistic_clients
  # POST /statistic_clients.json
  def create
    @statistic_client = StatisticClient.new(statistic_client_params)

    respond_to do |format|
      if @statistic_client.save
        format.html { redirect_to @statistic_client, notice: 'Statistic client was successfully created.' }
        format.json { render :show, status: :created, location: @statistic_client }
      else
        format.html { render :new }
        format.json { render json: @statistic_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistic_clients/1
  # PATCH/PUT /statistic_clients/1.json
  def update
    respond_to do |format|
      if @statistic_client.update(statistic_client_params)
        format.html { redirect_to @statistic_client, notice: 'Statistic client was successfully updated.' }
        format.json { render :show, status: :ok, location: @statistic_client }
      else
        format.html { render :edit }
        format.json { render json: @statistic_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistic_clients/1
  # DELETE /statistic_clients/1.json
  def destroy
    @statistic_client.destroy
    respond_to do |format|
      format.html { redirect_to statistic_clients_url, notice: 'Statistic client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statistic_client
      @statistic_client = StatisticClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statistic_client_params
      params[:statistic_client]
    end
end
