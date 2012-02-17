module Spud::Admin::CalendarsHelper
  def previous_calendar_month_path(date, url_for_options)
    date = date.advance(:months => -1)
    calendar = params[:calendar] ? params[:calendar] : nil
    link_to('&laquo; Previous Month'.html_safe, url_for(url_for_options.merge({:month => date.month, :year => date.year, :calendar => calendar})), :class => 'WdAdminCalendarLink').html_safe
  end

  def next_calendar_month_path(date, url_for_options)
    date = date.advance(:months => 1)
    calendar = params[:calendar] ? params[:calendar] : nil
    link_to('Next Month &raquo;'.html_safe, url_for(url_for_options.merge({:month => date.month, :year => date.year, :calendar => calendar})), :class => 'WdAdminCalendarLink').html_safe
  end
end
