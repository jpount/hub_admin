class ApisController < ApplicationController
  protect_from_forgery except: :register
  before_action :set_api, only: [:show, :edit, :update, :destroy]

  def register
    url = sanitize_url(params[:url])
    @api = Api.where("url = ?", url).first
    if !@api.nil?
      @api.last_ping = Time.now
    else
      @api = Api.new
      @api.url = url
      @api.display_name = url
      @api.last_ping = Time.now
    end
    if @api.save
      render json: { status: :ok, api: @api }
    else
      render json: { status: :unprocessable_entity, errors: @api.errors }
    end
  end

  # GET /apis
  # GET /apis.json
  def index
    timeout = get_timeout
    @apis = Api.get_valid_apis(timeout)
    @inactive_apis = Api.get_inactive_apis(timeout)
  end

  def delete_all
    Api.clear_apis
    timeout = get_timeout
    @apis = Api.get_valid_apis(timeout)
    @inactive_apis = Api.get_inactive_apis(timeout)
    redirect_to apis_path, notice: 'Deleted all API data'
  end

  # GET /apis/1/edit
  def edit
  end

  # PATCH/PUT /apis/1
  # PATCH/PUT /apis/1.json
  def update
    respond_to do |format|
      if @api.update(api_params)
        format.html { redirect_to apis_path, notice: 'Api was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apis/1
  # DELETE /apis/1.json
  def destroy
    @api.destroy
    respond_to do |format|
      format.html { redirect_to apis_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api
    @api = Api.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def api_params
    params[:api].permit(:id, :url, :last_ping, :alt_url, :ignore, :display_name, :api_type)
  end

end
