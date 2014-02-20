class CreateDashboardMetrics < ActiveRecord::Migration
  def change
    create_table :dashboard_metrics do |t|
      t.string  :metricable_type
      t.integer :metricable_id
      t.integer :total_count
      t.integer :success_count
      t.integer :error_count
      t.integer :last_entry_tps
      t.integer :last_exit_tps
      t.integer :max_entry_tps
      t.integer :max_exit_tps
      t.string  :ip
      t.string  :msg_name
      t.timestamps
    end
  end
end
