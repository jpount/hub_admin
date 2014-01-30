class AddConfigFlags < ActiveRecord::Migration
  def change
    add_column :confs, :show_lb, :boolean, default: false
    add_column :confs, :dashboard_refresh_ms, :integer, default: 5000
  end
end
