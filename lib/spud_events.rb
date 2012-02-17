module Spud
	module Events
		require 'spud_events/configuration'
		require 'spud_events/engine' if defined?(Rails)
    require 'spud_events/table_builder'
    require 'spud_events/calendar_builder'
	end
end
