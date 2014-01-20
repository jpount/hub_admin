class AddFiIgnore < ActiveRecord::Migration
  def change
    add_column :fis, :ignore, :boolean, default: false
  end
end
