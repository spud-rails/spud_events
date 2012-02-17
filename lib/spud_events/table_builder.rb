module Spud
  module Events
    class TableBuilder
      include ::ActionView::Helpers::TagHelper

      def initialize(objects, template, options)
        raise ArgumentError, "TableBuilder expects an Array but found a #{objects.inspect}" unless objects.is_a? Array
        @objects, @template, @options = objects, template, options
      end

      def head(*args, &block)
        if block_given?
          @template.content_tag(:thead, nil, options_from_hash(args), true, &block)
        else        
          @num_of_columns = args.size
          content = args.collect do |c|
              @template.content_tag(:th,c)
          end.join("\n").html_safe
          @template.content_tag(:thead, @template.content_tag(:tr,content,{},false))
        end
      end

      def head_r(*args, &block)
        raise ArgumentError, "Missing block" unless block_given?
        options = options_from_hash(args)
        head do
          @template.content_tag(:tr, nil, options, true, &block)
        end
      end

      def body(*args, &block)
        raise ArgumentError, "Missing block" unless block_given?
        options = options_from_hash(args)
        content = @objects.collect do |c|
            @template.with_output_buffer{block.call(c)}
        end.join("\n").html_safe
        @template.content_tag(:tbody, content, options, false)
      end
    
      def body_r(*args, &block)
        raise ArgumentError, "Missing block" unless block_given?
        options = options_from_hash(args)
        tds = @objects.collect do |thing|
            @template.with_output_buffer{block.call(thing)}
        end
        content = tds.collect do |td|
            @template.content_tag(:tr,td, {}, false)
        end.join("\n").html_safe
        "\n#{@template.content_tag(:tbody, content, options, false)}".html_safe
      end    

      def r(*args, &block)
        raise ArgumentError, "Missing block" unless block_given?
        options = options_from_hash(args)
        @template.content_tag(:tr, nil, options, true, &block)
      end

      def h(*args, &block)
        if block_given?
          @template.content_tag(:th, nil, options_from_hash(args), true, &block)
        else
          content = args.shift
          @template.content_tag(:th, content, options_from_hash(args))
        end        
      end

      def d(*args, &block)
        if block_given?
          @template.content_tag(:td, nil, options_from_hash(args), true, &block)
        else
          content = args.shift
          @template.content_tag(:td, content, options_from_hash(args))
        end        
      end

      private
    
      def options_from_hash(args)
        args.last.is_a?(Hash) ? args.pop : {}
      end
    
      # def content_tag(tag, content, *args, &block)
      #   options = options_from_hash(args)
      #   @template.content_tag(tag, content, options, &block)
      # end
    end
  end
end