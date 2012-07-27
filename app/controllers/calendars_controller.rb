class CalendarsController < ApplicationController

  layout Spud::Events.config.calendar_layout || 'spud/calendar'

  def show
    if params[:month]
      year = params[:year] ? params[:year] : Time.new.year
      begin
        @calendar_date = Time.local(year, params[:month])
      rescue
        @calendar_date = default_date
      end
    else
      @calendar_date = default_date
    end
    if params[:calendar] && calendar = SpudCalendar.find_by_title(params[:calendar].titleize)
      @events = calendar.spud_calendar_events.where(["start_at >= ?",@calendar_date]).order(:start_at).all
    else
      @events = SpudCalendarEvent.where(["start_at >= ?",@calendar_date]).order(:start_at).all
    end
    @current_calendar = params[:calendar] ? params[:calendar] : 0
    @page_title = @calendar_date.strftime("Calendar - %B %Y")
  end

  def default_date
    tempDate = Time.new
    return Time.local(tempDate.year,tempDate.month)

  end
end
