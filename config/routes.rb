Rails.application.routes.draw do
	namespace :spud do
		namespace :admin do
      # Events
      resources :calendar_events, :except => [:show, :index], :path => 'events', :as => "spud_calendar_events"
      resources :calendars, :except => [:show, :index], :path => 'calendars', :as => "spud_calendars"
      match 'events(/:month(/:year(/:calendar)))' => "calendar_events#index", :as => "list_spud_calendar_events"
		end
	end
  
  # Calendar
  match 'calendar(/:month(/:year(/:calendar)))' => "spud/calendars#show", :as => "calendar"
  match 'calendar_event/:id' => "spud/calendar_events#show", :as => "event"
end

