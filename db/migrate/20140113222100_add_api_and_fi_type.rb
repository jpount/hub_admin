class AddApiAndFiType < ActiveRecord::Migration
  def change
    add_column :apis, :api_type, :string, default: "IN"
    add_column :fis, :fi_type, :string, default: "SENDER"
  end
end
