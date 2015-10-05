module Jekyll
  class NoLinebreaksBlock < Liquid::Block
  
    def initialize(tag_name, text, tokens)
       super
    end

    def render(context)
      super.gsub(/\s+/, " ")
    end
  end
end

Liquid::Template.register_tag('nolinebreaks', Jekyll::NoLinebreaksBlock)
