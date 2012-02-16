class SpudCalendar < ActiveRecord::Base
  has_many :spud_calendar_events
  validates_presence_of :title, :color

end
