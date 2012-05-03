class SpudCalendar < ActiveRecord::Base
  has_many :spud_calendar_events, :dependent => :destroy
  validates_presence_of :title, :color

  attr_accessible :title, :color

end
