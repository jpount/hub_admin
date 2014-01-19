# RailsAdmin config file. Generated on January 18, 2014 13:44
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  ################  NO AUTH  ################
  config.authenticate_with {}
  config.current_user_method {}

  ################  Global configuration  ################
  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Payments Admin', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  #config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Api', 'ApiMetric', 'Conf', 'Dashboard', 'Fi', 'LoadBalancer', 'Metric', 'User', 'Widget']
  config.excluded_models = ['Dashboard', 'User']

  # Include specific models (exclude the others):
  # config.included_models = ['Api', 'ApiMetric', 'Conf', 'Dashboard', 'Fi', 'LoadBalancer', 'Metric', 'User', 'Widget']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  ###  Api  ###
  config.model 'Api' do
    # Found associations:
    configure :api_metrics, :has_many_association

    # Found columns:

  #     configure :id, :integer
  #     configure :api_id, :integer
  #     configure :last_ping, :datetime
  #     configure :url, :string
  #     configure :alt_url, :string
  #     configure :ignore, :boolean
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :display_name, :string
  #     configure :api_type, :string

  #   # Cross-section configuration:

       object_label_method :display_name     # Name of the method called for pretty printing an *instance* of ModelName
       label 'API'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
       label_plural 'APIs'      # Same, plural
     # weight 0                      # Navigation priority. Bigger is higher.
     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #    list do
  #       filters [:id, :name, :display_name]  # Array of field names which filters should be shown by default in the table header
  #       items_per_page 100    # Override default_items_per_page
  #       sort_by :id           # Sort column (default is primary key)
  #       sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #    end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  ApiMetric  ###

  config.model 'ApiMetric' do
      configure :api, :belongs_to_association
  #     configure :id, :integer
  #     configure :api_id, :integer         # Hidden
  #     configure :total_count, :integer
  #     configure :success_count, :integer
  #     configure :error_count, :integer
  #     configure :last_entry_tps, :integer
  #     configure :last_exit_tps, :integer
  #     configure :max_entry_tps, :integer
  #     configure :max_exit_tps, :integer
  #     configure :ip, :string
  #     configure :msg_name, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

     # Cross-section configuration:

        object_label_method :msg_name     # Name of the method called for pretty printing an *instance* of ModelName
        label 'API Metric'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
        label_plural 'API Metrics'      # Same, plural
  #      weight 0                      # Navigation priority. Bigger is higher.
        parent Api             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
       # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       items_per_page 100    # Override default_items_per_page
  #       sort_by :id           # Sort column (default is primary key)
  #       sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  Conf  ###

  config.model 'Conf' do
        configure :load_balancers, :has_many_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :ping_interval, :integer
  #     configure :nimbus_url, :string
  #     configure :cassandra_url, :string
  #     configure :hap_url, :string
  #     configure :hap_user, :string
  #     configure :hap_pwd, :string
  #     configure :fi_port, :integer
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :ganglia_url, :string
  #     configure :ganglia_host, :string

  #   # Cross-section configuration:

       object_label_method :id     # Name of the method called for pretty printing an *instance* of ModelName
       label 'Configuration'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
       label_plural 'Configs'      # Same, plural
       # weight 0                      # Navigation priority. Bigger is higher.
       # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
       # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       items_per_page 100    # Override default_items_per_page
  #       sort_by :id           # Sort column (default is primary key)
  #       sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end

  ###  Fi  ###

  config.model 'Fi' do
      configure :metric, :has_one_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :last_ping, :datetime
  #     configure :url, :string
  #     configure :alt_url, :string
  #     configure :ignore, :boolean
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :display_name, :string
  #     configure :fi_type, :string

  #   # Cross-section configuration:

        object_label_method :display_name     # Name of the method called for pretty printing an *instance* of ModelName
        label 'FI'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
        label_plural 'FIs'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  LoadBalancer  ###

  config.model 'LoadBalancer' do
      configure :conf, :belongs_to_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :conf_id, :integer         # Hidden
  #     configure :display_name, :string
  #     configure :url, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

        object_label_method :display_name     # Name of the method called for pretty printing an *instance* of ModelName
        label 'LoadBalancer'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
        label_plural 'LoadBalancers'      # Same, plural
       # weight 0                      # Navigation priority. Bigger is higher.
        parent Conf             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end


  ###  Metric  ###

  config.model 'Metric' do
      configure :fi, :belongs_to_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :fi_id, :integer         # Hidden
  #     configure :total_count, :integer
  #     configure :success_count, :integer
  #     configure :error_count, :integer
  #     configure :last_entry_tps, :integer
  #     configure :last_exit_tps, :integer
  #     configure :max_entry_tps, :integer
  #     configure :max_exit_tps, :integer
  #     configure :ip, :string
  #     configure :msg_name, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

        object_label_method :msg_name     # Name of the method called for pretty printing an *instance* of ModelName
        label 'FI Metric'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
        label_plural 'FI Metrics'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
        parent Fi             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end

  ###  User  ###

  # config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Widget  ###

  config.model 'Widget' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your widget.rb model definition

  #   # Found associations:

  #     configure :dashboard, :belongs_to_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :name, :string
  #     configure :kind, :string
  #     configure :source, :string
  #     configure :settings, :serialized
  #     configure :dashboard_id, :integer         # Hidden
  #     configure :update_interval, :integer
  #     configure :col, :integer
  #     configure :row, :integer
  #     configure :size_x, :integer
  #     configure :size_y, :integer

  #   # Cross-section configuration:

        object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
        label 'Widget'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
        label_plural 'Widgets'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  end

end
