module Jekyll
  class TikZUtil
    require 'digest/sha1'
    require 'fileutils'

    def self.formats 
      [ :svg, :png ]
    end
    
    def self.config
      { :format => :svg, :dir => 'assets/tikz', :sources => true }
    end
    # TODO check if site config overwrites this
    # TODO add defaults for style, alt attributes
   
    @@hashes = {}

    # Makes sure that the figure with the given text on the given page
    # is available with the given format.
    # Returns a file name (without extension) or nil if there was an error.
    def self.deliver(site, page, text, format = @@config[:format])
      hash = Digest::SHA1.hexdigest(text)
      
      pageid = page['url'].gsub(/^\/|\/$/, "").gsub("/", "-").sub(/\.\w+$/, "")
      
      # Use context to count TikZ blocks on this page
      if page["tikz-count"].nil?
        # New build! Clean up old keeps
        site.keep_files.delete_if { |f| /#{pageid}-\d+/ =~ f }
        
        # Set up counter
        page["tikz-count"] = 0 
      end
      page["tikz-count"] += 1
      
      # Give image a unique ID
      id = "#{pageid}-#{page["tikz-count"].to_s}"
      
      target = "#{site.dest.to_s}/#{config[:dir]}/"
      
      # Verify that format is valid
      if !TikZUtil.formats.include?(format)
        Jekyll.logger.warn("\nBuild Warning:", 
            "Illegal target format #{format.to_s} for TikZ image " +
            "##{page["tikz-count"]} in #{page["dir"]}/#{page["name"]}. " +
            "Falling back to #{self.config[:format]}.")
        format = self.config[:format]
      end
      
      if !File.exist?("#{target}/#{id}.#{format}") || @@hashes[id] != hash
        # Make sure that target directory is there
        FileUtils::mkdir_p("#{target}") if !File.exist?("#{target}")
        
        # Remove old stuff if it exists
        FileUtils::rm("#{target}/#{id}.tikz") if File.exist?("#{target}/#{id}.tikz")
        FileUtils::rm("#{target}/#{id}.#{format}") if File.exist?("#{target}/#{id}.#{format}")
        
        # Create TikZ file
        File.open("#{target}/#{id}.tikz", "w") { |f|
          f.write(text)
        }

        # Convert to desired target format
        cur = Dir.pwd
        Dir.chdir("#{target}")
        `tikz2#{format} "#{id}.tikz"`
        Dir.chdir(cur)
        
        if File.exist?("#{target}/#{id}.#{format}")
          @@hashes[id] = hash
        else
          Jekyll.logger.warn("\nBuild Warning:", 
            "Building TikZ image ##{page["tikz-count"]}" +
            " in #{page["dir"]}/#{page["name"]} failed.")
          return nil
        end
      end
      
      # Make sure the files are not cleaned up
      site.keep_files << "#{config[:dir]}/#{id}.tikz" if self.config[:sources]
      site.keep_files << "#{config[:dir]}/#{id}.#{format}"
      
      return id
    end
  end

  class TikZBlock < Liquid::Block 
    require 'shellwords'
           
    def initialize(tag_name, text, tokens)
      super
      
      @params = { 
        :alt    => "A graphic created with TikZ",
        :format => TikZUtil.config[:format],
        :style  => ""
      }
       
      param_name = nil
      text.shellsplit.each { |param|
        if /--(\w+)/ =~ param 
          param_name = $1.to_sym
        elsif param_name != nil
          @params[param_name] = param
          param_name = nil
        end
      }
      @params[:format] = @params[:format].to_sym
    end
    
    def render(context)
      site = context.registers[:site]
      page = context['page']

      file = TikZUtil.deliver(site, page, super, @params[:format])

      res = "<span class=\"tikz\">\n"
      if file != nil
        res += "  <img class=\"tikz #{@params[:format].to_s}\" " + 
                      "style=\"#{@params[:style]}\" " +
                      "src=\"/#{TikZUtil.config[:dir]}/#{file}.#{@params[:format]}\"  " +
                      "alt=\"#{@params[:alt]}\" />"
        if ( TikZUtil.config[:sources] )
          res += "<br/>\n"
          res += "  <sup>\n"
          res += "    [<a href=\"/#{TikZUtil.config[:dir]}/#{file}.tikz\">source</a>]\n"
          res += "  </sup>"
        end
      else
        res += "TikZ conversion failed"
      end  
      res += "</span>"
      
      return res
    end
  end
end

Liquid::Template.register_tag('tikz', Jekyll::TikZBlock)
