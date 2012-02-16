require 'spud_admin'
module Spud
	module Events
		 class Engine < Rails::Engine
			engine_name :spud_events
			initializer :admin do
				Spud::Core.configure do |config|
				  config.admin_applications += [{:name => "Events",:thumbnail => "spud/admin/events_thumb.png",:url => "/spud/admin/events",:order => 10}]
				end
			end
			initializer :assets do |config| 
				Rails.application.config.assets.precompile += [ 
				     "spud/admin/events*"
				]
			 end
		 end
	end
end
