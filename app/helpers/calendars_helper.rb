module CalendarsHelper
  def build_calendar_for(objects, *args, &block)
    raise ArgumentError, "Missing block" unless block_given?
    options = args.last.is_a?(Hash) ? args.pop : {}
    html_options = options[:html]
    builder = options[:builder] || Spud::Events::CalendarBuilder
    calendar = options[:calendar] || Spud::Events::Calendar

    content = with_output_buffer{block.call(builder.new(objects||[], self, calendar, options))}
    self.content_tag(:table, content, html_options, false)
  end
end
