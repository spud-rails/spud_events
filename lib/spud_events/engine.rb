require 'spud_core'
module Spud
	module Events
		 class Engine < Rails::Engine
			engine_name :spud_events

			def self.require_model(model_name)
        require "#{root}/app/models/#{model_name}"
      end

      def self.require_controller(controller_name)
        require "#{root}/app/controllers/#{controller_name}"
      end
			initializer :admin do
				Spud::Core.configure do |config|
				  config.admin_applications += [{:name => "Events", :thumbnail => "spud/admin/events_thumb.png", :url => "/spud/admin/events",:order => 10}]
				end
			end
			initializer :assets do |config|
				Rails.application.config.assets.precompile += [
          "spud/events.*",
          "spud/admin/events.*"
				]
			 end
		 end
	end
end
