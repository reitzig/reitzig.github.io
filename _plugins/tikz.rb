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
   
    @@hashes = {}

    # Makes sure that the figure with the given text on the given page
    # is available with the given format.
    # Returns a file name (without extension) or nil if there was an error.
    def self.deliver(site, page, text, format = @@config[:format])
      hash = Digest::SHA1.hexdigest(text)
      
      pageid = page["dir"].sub("/", "").gsub("/", "-") + 
               "-" + page["name"].sub(/\.\w+$/, "")
      
      # Use context to count TikZ blocks on this page
      if !page.has_key?("tikz-count")
        # New build! Clean up old keeps
        site.keep_files.delete_if { |f| /#{pageid}-\d+/ =~ f }
        
        # Set up counter
        page["tikz-count"] = 0 
      end
      page["tikz-count"] += 1
      
      # Give image a unique ID
      id = "#{pageid}-#{page["tikz-count"].to_s}"
      
      target = "#{site.dest.to_s}/#{config[:dir]}/"
      
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
          Jekyll.logger.warn("Build Warning:", 
            "Building TikZ image ##{page["tikz-count"]}" +
            " in #{page["dir"]}/#{page["name"]} failed.")
          return nil
        end
      end
      
      # Make sure the files are not cleaned up
      site.keep_files << "#{config[:dir]}/#{id}.tikz"
      site.keep_files << "#{config[:dir]}/#{id}.#{format}"
      
      return id
    end
  end

  class TikZBlock < Liquid::Block        
    def initialize(tag_name, text, tokens)
      super
      
      if TikZUtil.formats.include?(text.strip.to_sym)
        @format = text.strip.to_sym
      else
        @format = TikZUtil.config[:format]
      end
    end
    
    def render(context)
      site = context.registers[:site]
      page = context.registers[:page]

      file = TikZUtil.deliver(site, page, super, @format)

      res = "<span class=\"tikz\">\n"
      if file != nil
        res += "  <img class=\"tikz #{@format.to_s}\" src=\"/#{TikZUtil.config[:dir]}/#{file}.#{@format}\" />"
        
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
