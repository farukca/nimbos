require 'warden'
require 'simple_form'
require 'client_side_validations'
require 'table_for_collection'

module Nimbos
  class Engine < ::Rails::Engine
    isolate_namespace Nimbos

    config.middleware.use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = lambda { |env| Nimbos::SessionsController.action(:new).call(env) }
    end

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      Nimbos::User.find(id)
    end
    config.autoload_paths << "#{config.root}/lib/validators"

		config.generators do |g|
			g.test_framework :mini_test, spec: true, fixture: false
		end

  end
end
