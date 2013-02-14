class SpudCalendarEvent < ActiveRecord::Base
  belongs_to :spud_calendar
  validates_presence_of :title, :start_at, :end_at, :spud_calendar_id

  attr_accessible :title, :description, :start_at, :end_at, :all_day, :spud_calendar_id, :spud_calendar, :location, :address, :address_2, :city, :state, :zip

  def self.in_month_of(month)
    where(["spud_calendar_events.start_at <= ? AND spud_calendar_events.start_at >= ?", month.end_of_month, month.beginning_of_month])
  end

end
