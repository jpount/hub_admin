class CreateLoadBalancer < ActiveRecord::Migration
  def change
    create_table :load_balancers do |t|
      t.integer  :conf_id
      t.string   :display_name
      t.string   :user_name, default: 'opsworks'
      t.string   :password, default: 'password0'
      t.string   :proxy_type, default: 'FRONTEND'
      t.string   :proxy_name, default: 'application'
      t.string   :url
      t.timestamps
    end
  end
end
