class CreateDashboards < ActiveRecord::Migration

  def change

    create_table :dashboards do |t|
      t.string :name
      t.string :time
      t.string :layout
      t.boolean :locked, default: false
    end

    create_table :widgets do |t|
      t.string :name
      t.string :kind
      t.string :source
      t.text   :settings
      t.references :dashboard
      t.integer :update_interval
      t.integer :col
      t.integer :row
      t.integer :size_x
      t.integer :size_y
    end

  end

end
