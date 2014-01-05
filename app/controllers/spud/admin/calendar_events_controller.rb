class Spud::Admin::CalendarEventsController < Spud::Admin::ApplicationController

  layout 'spud/admin/detail'
  add_breadcrumb "Events", :spud_admin_list_spud_calendar_events_path
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

    if params[:spud_calendar] && calendar = SpudCalendar.find_by_title(params[:spud_calendar].titleize)
      @calendar_events = calendar.events
    else
      @calendar_events = SpudCalendarEvent
    end
    @calendar_events = @calendar_events.in_month_of(@calendar_date).order('spud_calendar_events.start_at ASC').all

    @calendars = SpudCalendar.all
    @current_calendar = params[:spud_calendar] ? params[:spud_calendar] : 0

    respond_with(@calendars, :include => :events)
  end

  def new
    @calendar_event = SpudCalendarEvent.new
    if params[:spud_calendar]
      @calendar_event.spud_calendar_id = SpudCalendar.find_by_title(params[:spud_calendar].titleize).id
    end
  end

  def edit
    @calendar_event = SpudCalendarEvent.find(params[:id])
  end

  def create
    @calendar_event = SpudCalendarEvent.new(calendar_event_params)
    flash[:notice] = 'Calendar event was successfully created.' if @calendar_event.save
    respond_with(@calendar_event, :location => spud_admin_list_spud_calendar_events_path)
  end

  def update
    @calendar_event = SpudCalendarEvent.find(params[:id])
    flash[:notice] = 'Calendar event was successfully updated.' if @calendar_event.update_attributes(calendar_event_params)
    respond_with(@calendar_event, :location =>spud_admin_list_spud_calendar_events_path)
  end

  def destroy
    @calendar_event = SpudCalendarEvent.find(params[:id])
    @calendar_event.destroy
    respond_with(@calendar_event, :location => spud_admin_list_spud_calendar_events_path)
  end

private

  def calendar_event_params
    params.require(:spud_calendar_event).permit(:title, :description, :start_at, :end_at, :all_day, :spud_calendar_id, :spud_calendar, :location, :address, :address_2, :city, :state, :zip)
  end

end
