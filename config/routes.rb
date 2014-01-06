Rails.application.routes.draw do

# Calendar
  get 'calendar(/:month(/:year(/:calendar)))' => "calendars#show", :as => "calendar"
  get 'calendar_event/:id' => "calendar_events#show", :as => "event"
	namespace :spud do
		namespace :admin do
      # Events
      resources :calendar_events, :except => [:index]
      resources :calendars, :except => [:index]
      get 'events(/:month(/:year(/:calendar)))' => "calendar_events#index", :as => "list_spud_calendar_events"
		end
	end


end

