class CreateAdmin < ActiveRecord::Migration
  def change
    create_table :confs do |t|
      t.integer  :ping_interval
      t.string   :nimbus_url
      t.string   :cassandra_url
      t.integer  :fi_port
      t.timestamps
    end
    create_table :fis do |t|
      t.datetime :last_ping
      t.string   :url
      t.string   :alt_url
      t.timestamps
    end
    create_table :metrics do |t|
      t.integer :fi_id
      t.integer :total_count
      t.integer :success_count
      t.integer :error_count
      t.integer :last_entry_tps
      t.integer :last_exit_tps
      t.integer :max_entry_tps
      t.integer :max_exit_tps
      t.string :ip
      t.string :msg_name
      t.timestamps
    end
    create_table :api_metrics do |t|
      t.integer :api_id
      t.integer :total_count
      t.integer :success_count
      t.integer :error_count
      t.integer :last_entry_tps
      t.integer :last_exit_tps
      t.integer :max_entry_tps
      t.integer :max_exit_tps
      t.string :ip
      t.string :msg_name
      t.timestamps
    end
    create_table :apis do |t|
      t.integer :api_id
      t.datetime :last_ping
      t.string   :url
      t.string   :alt_url
      t.timestamps
    end
    add_index "metrics", ["ip"], name: "index_metrics_on_ip"
    add_index "metrics", ["msg_name"], name: "index_metrics_on_name"
    add_index "api_metrics", ["ip"], name: "index_apimetrics_on_ip"
    add_index "api_metrics", ["msg_name"], name: "index_apimetrics_on_name"
    add_index "apis", ["api_id"], name: "index_api_on_id"
    add_index "apis", ["url"], name: "index_api_on_url"
    add_index "fis", ["id"], name: "index_fi_on_id"
    add_index "fis", ["url"], name: "index_fi_on_url"
  end
end