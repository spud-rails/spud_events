class CalendarEventsController < ApplicationController
	def show
		@event = SpudCalendarEvent.find(params[:id])
	end
end
