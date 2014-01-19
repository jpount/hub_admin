class ConfsController < ApplicationController
  before_action :set_conf, only: [:show, :edit, :update, :destroy]

  # GET /confs
  # GET /confs.json
  def index
    @confs = Conf.all
  end

  # GET /confs/1
  # GET /confs/1.json
  def show
  end

  # GET /confs/new
  def new
    @conf = Conf.new
  end

  # GET /confs/1/edit
  def edit
  end

  # POST /confs
  # POST /confs.json
  def create
    @conf = Conf.new(conf_params)

    respond_to do |format|
      if @conf.save
        format.html { redirect_to confs_path, notice: 'Config was successfully created.' }
        format.json { render action: 'show', status: :created, location: @conf }
      else
        format.html { render action: 'new' }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /confs/1
  # PATCH/PUT /confs/1.json
  def update
    respond_to do |format|
      if @conf.update(conf_params)
        format.html { redirect_to confs_path, notice: 'Config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confs/1
  # DELETE /confs/1.json
  def destroy
    @conf.destroy
    respond_to do |format|
      format.html { redirect_to confs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conf
      @conf = Conf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conf_params
      params[:conf].permit(:id, :nimbus_url, :cassandra_url, :fi_port, :ping_interval, :hap_url, :hap_user, :hap_pwd, :ganglia_host, :ganglia_url)
    end

end
