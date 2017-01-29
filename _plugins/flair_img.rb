## Liquid tag 'maincolumn-figure' used to add image data that fits within the
## main column area of the layout
## Usage {% maincolumn 'path/to/image' 'This is the caption' %}
#
module Jekyll
  class FlairImageTag < Liquid::Tag

  	require "shellwords"

    def initialize(tag_name, text, tokens)
      super
      @text = text.shellsplit
    end

    def render(context)
      @text[1] = "" if @text[1].nil?
      "<p class=\"flairimg\"><a href=\"#{@text[0]}\"><img src=\"#{@text[0]}\" alt=\"#{@text[1]}\" title=\"#{@text[1]}\" /></a></p>"
    end
  end
end

Liquid::Template.register_tag('flairimg', Jekyll::FlairImageTag)
