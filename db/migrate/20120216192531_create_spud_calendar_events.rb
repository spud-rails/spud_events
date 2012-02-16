class CreateSpudCalendarEvents < ActiveRecord::Migration
  def change
    create_table :spud_calendar_events do |t|
      t.references :spud_calendar
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :all_day

      t.timestamps
    end
    add_index :spud_calendar_events, :spud_calendar_id
  end
end
