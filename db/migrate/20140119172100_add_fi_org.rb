class AddFiOrg < ActiveRecord::Migration
  def change
    add_column :fis, :fi_org, :string, default: "CBA"
  end
end
