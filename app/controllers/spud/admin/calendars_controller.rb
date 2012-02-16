class Spud::Admin::CalendarsController < Spud::Admin::ApplicationController
  
  layout 'spud/admin/events/detail'
  add_breadcrumb "Calendars", :spud_admin_calendars_path
  belongs_to_spud_app :events
  
  respond_to :html, :xml, :json, :js

  def new
    @calendar = SpudCalendar.new
    respond_with(@calendar)
  end

  def create
    @calendar = SpudCalendar.new(params[:calendar])
    if @calendar.save
      render :action => "show"
    else
      render :action => "new"
    end
  end

  def edit
    @calendar = SpudCalendar.find(params[:id])
    respond_with(@calendar)
  end

  def update
    @calendar = SpudCalendar.find(params[:id])
    if @calendar.update_attributes(params[:calendar])
      flash[:notice] = 'Calendar was successfully updated.'
      render :action => "show"
    else
      render :action => "edit"
    end
  end

  def destroy
    @calendar = SpudCalendar.find(params[:id])
    @calendar.events.each do |event|
      event.update_attribute(:calendar_id, 0)
    end
    flash[:notice] = 'Calendar was successfully deleted.' if @calendar.destroy
    respond_with(@calendar)
  end
  
end
