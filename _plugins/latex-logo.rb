module Jekyll
  class RenderLaTeXLogoTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      if @tag_name == "latex"
        "<span class=\"latex\">L<sup>a</sup>T<sub>e</sub>X</span>"
      elsif @tag_name == "tex"  
        "<span class=\"latex\">T<sub>e</sub>X</span>"
      else
        @tag_name
      end
    end
  end
end

Liquid::Template.register_tag('latex', Jekyll::RenderLaTeXLogoTag)
Liquid::Template.register_tag('tex', Jekyll::RenderLaTeXLogoTag)

