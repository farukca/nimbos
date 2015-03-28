require 'warden'
module Nimbos
  class Engine < ::Rails::Engine
    isolate_namespace Nimbos

    config.i18n.default_locale = "en-EN"
    config.i18n.load_path += Dir[config.root.join('locales', '*.{yml}').to_s]

    config.autoload_paths << "#{config.root}/lib/validators"
    
		config.generators do |g|
			g.test_framework :minitest, spec: true, fixture: false
		end

    config.to_prepare do
      root = Nimbos::Engine.root
      extenders_path = root + "app/extenders/**/*.rb"
      Dir.glob(extenders_path) do |file|
        Rails.configuration.cache_classes ? require(file) : load(file)
      end
    end

    initializer "nimbos.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        helper Nimbos::UsersHelper
        helper Nimbos::PatronsHelper
        helper Nimbos::BranchesHelper
        helper Nimbos::CountriesHelper
        helper Nimbos::PostsHelper
        helper Nimbos::CurrenciesHelper
        helper Nimbos::CalendarHelper
      end
    end

  end
end
