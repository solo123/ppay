class BulletinBoardSystemsController < ApplicationController
  before_action :set_bulletin_board_system, only: [:show, :edit, :update, :destroy]

  # GET /bulletin_board_systems
  # GET /bulletin_board_systems.json
  def index
    @collection = BulletinBoardSystem.order("updated_at desc")
  end

  # GET /bulletin_board_systems/1
  # GET /bulletin_board_systems/1.json
  def show
  end

  # GET /bulletin_board_systems/new
  def new
    @object = BulletinBoardSystem.new
    #
    @object.publisher_id = current_user.id

  end

  # GET /bulletin_board_systems/1/edit
  def edit
  end

  # POST /bulletin_board_systems
  # POST /bulletin_board_systems.json
  def create
    @object = BulletinBoardSystem.new(bulletin_board_system_params)
    respond_to do |format|
      if @object.save
        format.html { redirect_to @object, notice: 'Bulletin board system was successfully created.' }
        format.json { render :show, status: :created, location: @object }
      else
        format.html { render :new }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulletin_board_systems/1
  # PATCH/PUT /bulletin_board_systems/1.json
  def update
    respond_to do |format|
      # user_id
      @object.publisher_id = current_user.id
      if @object.update(bulletin_board_system_params)
        # 更新成功后要通知agent系统更新
        # $redis.publish 'channel', 'content'
        # Agent.all.each do |agent|
        #   $redise.publish "agent_#{agent.id}_bbs", @object.context
        # end

        format.html { redirect_to @object, notice: 'Bulletin board system was successfully updated.' }
        format.json { render :show, status: :ok, location: @object }
      else
        format.html { render :edit }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletin_board_systems/1
  # DELETE /bulletin_board_systems/1.json
  def destroy
    @object.destroy
    respond_to do |format|
      format.html { redirect_to bulletin_board_systems_url, notice: 'Bulletin board system was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin_board_system
      @object = BulletinBoardSystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulletin_board_system_params
      params.require(:bulletin_board_system).permit(:deadtime, :title, :content)
    end
end
