class CreateSpudCalendars < ActiveRecord::Migration
  def change
    create_table :spud_calendars do |t|
      t.string :title
      t.column :color, 'binary(6)'
      
      t.timestamps
    end
    
    add_index :spud_calendars, :title
  end
end
