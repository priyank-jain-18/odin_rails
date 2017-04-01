require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OdinFlightBooker
  class Application < Rails::Application
	#so that no useless stuff is generated
    config.generators.assets = false
    config.generators.helper = false    
    config.generators.template_engine = false
  end
end
