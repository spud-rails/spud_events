module Spud::Admin::CalendarsHelper
  def link_to_previous_calendar_month(date, url_for_options)
    date = date.advance(:months => -1)
    calendar = params[:calendar] ? params[:calendar] : nil
    link_to('&laquo; Previous Month'.html_safe, url_for(url_for_options.merge({:month => date.month, :year => date.year, :calendar => calendar})), :class => 'spud_events_calendar_link previous_calendar btn').html_safe
  end

  def link_to_next_calendar_month(date, url_for_options)
    date = date.advance(:months => 1)
    calendar = params[:calendar] ? params[:calendar] : nil
    link_to('Next Month &raquo;'.html_safe, url_for(url_for_options.merge({:month => date.month, :year => date.year, :calendar => calendar})), :class => 'spud_events_calendar_link next_calendar btn').html_safe
  end
end
