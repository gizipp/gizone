# config/initializers/will_paginate.rb

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options, collection = collection, nil if collection.is_a? Hash
      # Taken from original will_paginate code to handle if the helper is not passed a collection object.
      collection ||= infer_collection_from_controller
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag :div, tag(:ul, html, :class => "pagination"), container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def gap
        tag :li, link('&hellip;'.html_safe, '#'), :class => 'disabled'
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'),
        :class => [(classname[0..3] if @options[:page_links]), (classname if @options[:page_links]), ('disabled' unless page)].join(' ')
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, '', 'previous')
      end

      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, '', 'next')
      end

      def link(text, target, attributes = {})
        if target.is_a? Fixnum
          attributes[:class] = rel_value(target)
          # attributes[:class] = class_value(target)
          target = url(target)
        end
        attributes[:href] = target
        tag(:a, text, attributes)
      end

      def link(text, target, attributes = {})
        if target.is_a? Fixnum
          attributes[:class] = rel_value(target)
          target = url(target)
        end
        attributes[:href] = target
        tag(:a, text, attributes)
      end

      # def tag(name, value, attributes = {})
      #   string_attributes = attributes.inject('') do |attrs, pair|
      #     unless pair.last.nil?
      #       attrs << %( #{pair.first}="#{CGI::escapeHTML(pair.last.to_s)}")
      #     end
      #     attrs
      #   end
      #   "<#{name}#{string_attributes}>#{value}</#{name}>"
      # end

      def rel_value(page)
        case page
        when @collection.current_page - 1; 'fui-arrow-right'
        when @collection.current_page + 1; 'fui-arrow-right'
        # when 1; 'start'
        end
      end

      # def class_value(page)
      #   case page
      #     when @collection.current_page > 1 && @collection.current_page - 1 ; 'fui-arrow-left'
      #     when @collection.current_page < total_pages && @collection.current_page + 1 ; 'fui-arrow-right'
      #   end
      # end
    end
  end
end