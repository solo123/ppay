class ImpOpsController < ApplicationController
  before_action :set_imp_op, only: [:show, :edit, :update, :destroy]

  # GET /imp_ops
  # GET /imp_ops.json
  def index
    @q = ImpOp.ransack(params[:q])
    @imp_ops = @q.result(distinct: true).page(params[:page])

  end

  # GET /imp_ops/1
  # GET /imp_ops/1.json
  def show
  end

  # GET /imp_ops/new
  def new
    @imp_op = ImpOp.new
  end

  # GET /imp_ops/1/edit
  def edit
  end

  # POST /imp_ops
  # POST /imp_ops.json
  def create
    @imp_op = ImpOp.new(imp_op_params)

    respond_to do |format|
      if @imp_op.save
        format.html { redirect_to @imp_op, notice: 'Imp op was successfully created.' }
        format.json { render :show, status: :created, location: @imp_op }
      else
        format.html { render :new }
        format.json { render json: @imp_op.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imp_ops/1
  # PATCH/PUT /imp_ops/1.json
  def update
    respond_to do |format|
      if @imp_op.update(imp_op_params)
        format.html { redirect_to @imp_op, notice: 'Imp op was successfully updated.' }
        format.json { render :show, status: :ok, location: @imp_op }
      else
        format.html { render :edit }
        format.json { render json: @imp_op.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imp_ops/1
  # DELETE /imp_ops/1.json
  def destroy
    @imp_op.destroy
    respond_to do |format|
      format.html { redirect_to imp_ops_url, notice: 'Imp op was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imp_op
      @imp_op = ImpOp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imp_op_params
      params[:imp_op]
    end
end
