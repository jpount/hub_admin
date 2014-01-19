class LayoutController < DashboardsController
  def index
    render :text => "", :layout => "dashboards"
  end
end