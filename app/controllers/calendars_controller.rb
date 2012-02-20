class CalendarsController < ApplicationController
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
      @events = calendar.spud_calendar_events
    else
      @events = SpudCalendarEvent.all
    end
    @current_calendar = params[:calendar] ? params[:calendar] : 0
    @page_title = @calendar_date.strftime("Calendar - %B %Y")  
  end
  
  def default_date
    Time.new
  end
end
