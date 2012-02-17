module Spud
  module Events
    class CalendarBuilder < Spud::Events::TableBuilder
      def initialize(objects, template, calendar, options)
        super(objects, template, options)
        @calendar = calendar.new(options)
        @today = options[:today] || Time.now
      end    
                
      def day(*args,&block)
          raise ArgumentError, "Missing block" unless block_given?
          options = options_from_hash(args)
          day_method = options.delete(:day_method) || :start_at
          id_pattern = options.delete(:id)
          activity_class = options.delete(:activity)
          output = ""
          @calendar.objects_for_days(@objects, day_method).to_a.sort{|a1, a2| a1.first <=> a2.first }.each do |o|
              key, array = o
              day, objects = array
            
              output << @template.tag(:tr,options,true) if (day.wday ==  @calendar.first_weekday)
              output << @template.tag(:td,td_options(day, id_pattern, (objects.empty? ? nil: activity_class)), true)
              output << @template.with_output_buffer{block.call(day, objects)}
              output << '</td>'
              output << '</tr>' if (day.wday ==  @calendar.last_weekday)
          end
          @template.content_tag(:tbody, output.html_safe, {}, false)  
      end
            
      private
            
      def objects_for_days
        @calendar.objects_for_days(@objects)
      end
                
      def td_options(day, id_pattern, activity_class)
        options = {}
        if(day.strftime("%Y-%m-%d") ==  @today.strftime("%Y-%m-%d"))
          options[:class] = 'today'
        elsif(day.month != @calendar.month)
          options[:class] = 'notmonth'
        elsif(day.wday == 0 or day.wday == 6)
          options[:class] = 'weekend'
        elsif activity_class
          options[:class] = activity_class
        end
        if id_pattern
          options[:id] = day.strftime(id_pattern)
        end
            
        options
      end
            
    end

    class Calendar
      attr_accessor :first_weekday, :last_weekday, :month
      def initialize(options={})
        @year = options[:year] || Time.now.year
        @month = options[:month] || Time.now.month
        @first_day_of_week = options[:first_day_of_week] || 0
        @first_weekday = first_day_of_week(@first_day_of_week)
        @last_weekday = last_day_of_week(@first_day_of_week)
        @first = Date.civil(@year, @month, 1)
        @last = Date.civil(@year, @month, -1)           
      end
    
      def each_day
        first_day.upto(last_day) do |day|
          yield(day)
        end
      end
    
      def last_day
        last = @last
        while(last.wday % 7 != @last_weekday % 7)
          last = last.next
        end   
        last
      end
    
      def first_day
        first = @first - 6
        while(first.wday % 7 != (@first_weekday) % 7)
          first = first.next
        end
        first
      end      
    
      def objects_for_days(objects, day_method)
        unless @objects_for_days
          @objects_for_days = {}
          days.each{|day| @objects_for_days[day.strftime("%Y-%m-%d")] = [day, []]}
          objects.each do |o|
            date = o.send(day_method.to_sym).strftime("%Y-%m-%d")
            if @objects_for_days[date]
              @objects_for_days[date][1] << o
            end
          end
        end
        @objects_for_days
      end
    
      def days
        unless @days
          @days = []
          each_day{|day| @days << day} 
        end
        @days     
      end    
    
      def mjdays
        unless @mjdays
          @mdays = []
          each_day{|day| @days << day} 
        end
        @days     
      end    
    
      def first_day_of_week(day)
        day
      end
    
      def last_day_of_week(day)
        if day > 0
          day - 1
        else
          6
        end
      end    
    end
  end
end
