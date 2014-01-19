class FisController < ApplicationController
  protect_from_forgery except: :ping
  before_action :set_fi, only: [:edit, :update, :destroy]

  def ping
    url = sanitize_url(params[:id])
    @fi = Fi.where("url = ?", url).first
    if !@fi.nil?
      @fi.last_ping = Time.now
    else
      @fi = Fi.new
      @fi.url = params[:id]
      @fi.display_name = params[:id]
      @fi.last_ping = Time.now
    end
      if @fi.save
        render json: { status: :ok, fi: @fi }
      else
        render json: { status: :unprocessable_entity, errors: @fi.errors }
      end
  end

  # GET /fis
  # GET /fis.json
  def index
    get_common
  end

  def delete_all
    Fi.clear_fis
    get_common
    redirect_to fis_path, notice: 'FI records were deleted.'
  end

  # GET /fis/1/edit
  def edit
  end

  # PATCH/PUT /fis/1
  # PATCH/PUT /fis/1.json
  def update
    respond_to do |format|
      if @fi.update(fi_params)
        format.html { redirect_to fis_path, notice: 'Fi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fis/1
  # DELETE /fis/1.json
  def destroy
    @fi.destroy
    respond_to do |format|
      format.html { redirect_to fis_url }
      format.json { head :no_content }
    end
  end

  private

  def get_common
    timeout = get_timeout
    @fis = Fi.get_valid_fis(timeout)
    @inactive_fis = Fi.get_inactive_fis(timeout)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_fi
    @fi = Fi.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def fi_params
    params[:fi].permit(:id, :url, :last_ping, :alt_url, :ignore, :display_name, :fi_type, :fi_org)
  end

end
