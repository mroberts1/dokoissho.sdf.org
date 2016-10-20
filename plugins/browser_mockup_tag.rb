module Jekyll

  ##
  # Adds the Liquid tag {% browser_mockup %}
  #
  # Requires an image url as the first argument.
  #
  # Accepts an optional hash as the second parameter, which can contain the
  # following keys:
  #  - :url - The url to display in the browser bar
  #
  # Examples:
  #
  #  1. No browser bar, just an image
  #     {% browser_mockup image.png %}
  #
  #  2. Browser bar with url
  #     {% browser_mockup image.png, url: "http://example.org/" %}
  #
  class BrowserMockupTag < Liquid::Tag
    SYNTAX_REGEX = /(#{Liquid::QuotedFragment}+)(\s+(#{Liquid::QuotedFragment}+))?/o

    def initialize(_tag_name, markup, _tokens)
      super

      # Extract the image url and any attributes from the tag.
      if markup =~ SYNTAX_REGEX
        @image_url = Regexp.last_match[1]

        @attributes = {}
        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = Liquid::Expression.parse(value)
        end
      end
    end

    ##
    # Render the browser window.
    def render(_context)
      @browser_url = @attributes['url']
      render_header + render_contents + render_url + render_footer
    end

    # -----
    # -- Utility functions for rendering each part of the window.

    def render_header
      class_names = ''
      class_names += 'has-url' if @browser_url
      "<figure class=\"browser-mockup #{class_names}\">"
    end

    def render_footer
      '</figure>'
    end

    def render_contents
      "<div class=\"browser-mockup-inner\"><img src=\"#{@image_url}\"></div>"
    end

    def render_url
      @browser_url ? "<p class=\"browser-mockup-url\"><span>#{@browser_url}</span></p>" : ""
    end
  end
end

Liquid::Template.register_tag('browser_mockup', Jekyll::BrowserMockupTag)
