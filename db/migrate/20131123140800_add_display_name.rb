class AddDisplayName < ActiveRecord::Migration
  def change
    add_column :fis, :display_name, :string
    add_column :apis, :display_name, :string
    add_index "apis", ["display_name"], name: "index_api_on_display_name"
    add_index "fis", ["display_name"], name: "index_fi_on_display_name"
  end
end