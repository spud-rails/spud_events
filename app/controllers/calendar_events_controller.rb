class CalendarEventsController < ApplicationController
  
  layout Spud::Events.config.calendar_layout || 'spud/calendar'
  
	def show
		@event = SpudCalendarEvent.find(params[:id])
	end
end
