module Jekyll

  class AsideBlock < Liquid::Block
    ASIDE_WITH_CLASS = /([\w\s\-]+)/i

    def initialize(_tag_name, markup, _tokens)
      @class = nil
      if markup =~ ASIDE_WITH_CLASS
        @class = Regexp.last_match[1]
        @class = @class.strip
      end
      super
    end

    def render(_context)
      content = super
      content = content.strip

      if @class
        source = "<aside class=\"aside aside--#{@class}\" role=\"complementary\">\n"
      else
        source = "<aside class=\"aside\">\n"
      end

      # TODO: Don't rely on Kramdown here
      source += Kramdown::Document.new(content).to_html
      source += "\n</aside>"
      source
    end
  end
end

Liquid::Template.register_tag('aside', Jekyll::AsideBlock)
