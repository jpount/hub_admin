class AddGangliaUrl < ActiveRecord::Migration
  def change
    add_column :confs, :ganglia_url, :string
    add_column :confs, :ganglia_host, :string
  end
end
