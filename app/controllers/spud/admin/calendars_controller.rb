class Spud::Admin::CalendarsController < Spud::Admin::ApplicationController

  layout 'spud/admin/detail'
  add_breadcrumb "Events", :spud_admin_list_spud_calendar_events_path

  belongs_to_spud_app :events

  before_filter :load_calendar, :only => [:show,:edit,:update,:destroy]

  respond_to :html, :xml, :json, :js

  def new
    @page_name = "New Calendar"
    @calendar = SpudCalendar.new
    respond_with(@calendar)
  end

  def create
    @calendar = SpudCalendar.new(calendar_params)
    if @calendar.save
      redirect_to spud_admin_list_spud_calendar_events_path
    else
      render :action => "new"
    end
  end

  def edit
    @page_name = "Edit Calendar"
    @calendar = SpudCalendar.find(params[:id])
    respond_with(@calendar)
  end

  def update
    if @calendar.update_attributes(calendar_params)
      flash[:notice] = 'Calendar was successfully updated.'
      redirect_to spud_admin_list_spud_calendar_events_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @calendar.destroy
    respond_with(@calendar) do |format|
      format.js { render(:nothing => true) }
    end
  end

private

  def load_calendar
    @calendar = SpudCalendar.where(:id => params[:id]).first
    if @calendar.blank?
      flash[:error] = "Calendar not found!"
      redirect_to spud_admin_list_spud_calendar_events_path and return false
    end
    return true
  end

  def calendar_params
    params.require(:spud_calendar).permit(:title, :color)
  end

end
