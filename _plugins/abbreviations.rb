module Jekyll
  class AbbreviationsTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text.split(/\s+/)
      if @text.size == 1
        @text = @text[0].split("")
      end
    end

    def render(context)
      #@text.join(".&#8239;") + "." # That's a thinner non-breakable space
      # But since it's not really a thin space, use this instead:
      "<span style=\"white-space: nowrap;\">#{@text.join(".&thinsp;")}.</span>"
    end
  end
end

Liquid::Template.register_tag('abbr', Jekyll::AbbreviationsTag)

