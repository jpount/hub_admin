class LoadBalancersController < ApplicationController

  protect_from_forgery

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def load_blancer_params
    params[:load_balancer].permit(:id, :url, :display_name, :conf_id)
  end

end
