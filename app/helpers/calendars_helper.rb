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

  def get_calendar_options(text_for_all)
    options_for_select(SpudCalendar.all.collect { |f| [f.title, f.title.gsub(/([^A-Z0-9]+)/i, "-").downcase] }.insert(0, text_for_all), @current_calendar)
  end

  def calendar_fore_color(backcolor)
    fore_color = "ffffff"
    if backcolor.length != 6
      return fore_color
    end

    red = backcolor[0,2].hex
    green = backcolor[2,2].hex
    blue = backcolor[4,2].hex

    perceived_brightness = Math.sqrt(red*red*0.241 + green*green*0.691 + blue*blue*0.068)


    # average = (red+green+blue) / 3
    if(perceived_brightness >= 130)
      return "000000"
    else
      return fore_color
    end
  end
end
