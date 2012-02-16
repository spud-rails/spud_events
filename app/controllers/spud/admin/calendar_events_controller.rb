class Spud::Admin::CalendarEventsController < Spud::Admin::ApplicationController
  
  layout 'spud/admin/events/detail'
  add_breadcrumb "Events", :spud_admin_calendar_events_path
  belongs_to_spud_app :events
  
  respond_to :html, :xml, :json
  respond_to :js, :only => [:index, ]

  def index
    if params[:month]
      year = params[:year] ? params[:year] : Time.new.year
      begin
        @calendar_date = Time.local(year, params[:month])
      rescue
        @calendar_date = Time.new
      end
    else
      @calendar_date = Time.new
    end

    if params[:calendar] && calendar = SpudCalendar.find_by_title(params[:calendar].titleize)
      @calendar_events = calendar.events.in_month_of(@calendar_date)
    else
      @calendar_events = SpudCalendarEvent.in_month_of(@calendar_date)
    end
    
    @calendars = SpudCalendar.all
    @current_calendar = params[:calendar] ? params[:calendar] : 0

    respond_with(@calendars, :include => :events)
  end

  def new
    @calendar_event = SpudCalendarEvent.new(:date => DateTime.now)
    if params[:calendar]
      @calendar_event.calendar_id = SpudCalendar.find_by_title(params[:calendar].titleize).id
    end
  end

  def edit
    @calendar_event = SpudCalendarEvent.find(params[:id])
  end

  def create
    @calendar_event = SpudCalendarEvent.new(params[:calendar_event])
    flash[:notice] = 'Calendar event was successfully created.' if @calendar_event.save
    respond_with(@calendar_event, :location => admin_calendar_events_path)
  end

  def update
    @calendar_event = SpudCalendarEvent.find(params[:id])
    flash[:notice] = 'Calendar event was successfully updated.' if @calendar_event.update_attributes(params[:calendar_event])
    respond_with(@calendar_event, :location =>spud_admin_calendar_events_path)
  end

  def destroy
    @calendar_event = SpudCalendarEvent.find(params[:id])
    @calendar_event.destroy
    respond_with(@calendar_event, :location => spud_admin_calendar_events_path)
  end

end
