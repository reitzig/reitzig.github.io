module Jekyll
  class FixBibBlock < Liquid::Block
  
    def initialize(tag_name, text, tokens)
      super
      
      @details = true
      @keyaslabel = false
      @keepkey = false
      
      text.split(/\s+/).each { |arg|        
        if arg == "--nodetails"
          @details = false
        elsif arg == "--keyaslabel"
          @keyaslabel = true
        elsif arg == "--keepkey"
          @keepkey = true
        end
      }
    end

    def render(context)
      res = super
      
      # Remove spans
      res.gsub!(/<span id="([^"]*)">(.*?)<\/span>/, "<p id=\"\\1\">\\2</p>")
      
      if @keyaslabel
        # Remove list bullets
        res.gsub!(/<ol class=\"([^"]+)\">/, "<ol class=\"\\1\" style=\"list-style: none;\">")
        
        # Position key up front
        res.gsub!(/<p id="([^"]*)">\[(\d+)\](.*?)<\/p>/, 
                  "<table class=\"fixedbib\"><tr><td><span id=\"\\1\" class=\"bibkey\">[\\2]</span></td><td><p>\\3</p></td></tr></table>")
      elsif !@keepkey
        res.gsub!(/<p id="([^"]*)">\[\d+\]/, "<p id=\"\\1\">")
      end
        
      # Remove details link if requested        
      if !@details
        res.gsub!(/<a class="details" href=".*?">Details<\/a>/, "")
      end
      
      return res
    end
  end
end

Liquid::Template.register_tag('fixbibliography', Jekyll::FixBibBlock)
