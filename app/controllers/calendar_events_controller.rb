class CalendarEventsController < ApplicationController
  
  layout 'spud/calendar'
  
	def show
		@event = SpudCalendarEvent.find(params[:id])
	end
end
