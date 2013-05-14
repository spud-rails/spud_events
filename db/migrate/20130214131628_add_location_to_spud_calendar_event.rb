class AddLocationToSpudCalendarEvent < ActiveRecord::Migration
  def change
    add_column :spud_calendar_events, :location, :string
    add_column :spud_calendar_events, :address, :string
    add_column :spud_calendar_events, :address_2, :string
    add_column :spud_calendar_events, :city, :string
    add_column :spud_calendar_events, :state, :string
    add_column :spud_calendar_events, :zip, :string
  end
end
