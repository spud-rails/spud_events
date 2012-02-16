class SpudCalendarEvent < ActiveRecord::Base
  belongs_to :spud_calendar
  validates_presence_of :title, :start_at, :end_at, :calendar_id
  
  def self.in_month_of(month)
    find(:all, :conditions => ["spud_calendar_events.start_at <= ? AND spud_calendar_events.start_at >= ?", month.end_of_month, month.beginning_of_month])
  end
  
end
