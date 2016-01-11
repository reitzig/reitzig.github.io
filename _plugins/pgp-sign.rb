module Jekyll
  class PgpService
    require 'digest/sha1'
    require 'fileutils'
    
    private
    @@tosign = []
    @@signed = {}
    
    def self.sigfile(url)
      "/" + url.sub(/^\//, "").sub(/\/$/, "/index").gsub("/", "-") + ".sig"
    end
    
    def self.siglist(url)
      url.sub(/\/$/, "/index.html").sub(/(\.html)?$/, ".sig.html")
    end
    
    def self.find_file(site, url)      
      if !File.file?(url)
        url = site.dest.to_s + url if File.file?(site.dest.to_s + url)
        url = site.dest.to_s + url + ".html" if File.file?(site.dest.to_s + url + ".html")
        url = site.dest.to_s + url + "index.html" if File.file?(site.dest.to_s + url + "index.html")
      end
      url
    end
    
    def self.sign(site, url, pgp)
      source = find_file(site, url)
      target_dir = site.dest.to_s + "/" + pgp['target']
      target = target_dir + sigfile(url)
      
      if !File.file?(source) 
        Jekyll.logger.warn("Could not track down '#{source}' for signing.")
        return false
      end
      FileUtils.mkdir(target_dir) if !File.exist?(target_dir)
      
      new_hash = Digest::SHA1.file(source).to_s.strip
      
      if !File.file?(target) || new_hash != @@signed[url]
        Jekyll.logger.info("Signing #{url}")
        FileUtils.rm(target) if File.exist?(target)
        `gpg --local-user #{pgp['key-id']} --detach-sign --output #{target} #{source}`
      end
      
      if File.file?(target) 
        if !site.keep_files.include?(target)
          site.keep_files << target
          @@signed[url] = new_hash
        end
        return true
      else
        @@signed[url] = nil
        return false
      end
    end
    
    def self.create_siglist(site, url, pgp, files)
      File.open("#{site.dest.to_s}/#{siglist(url)}", "w") { |f|
        f.write("<!DOCTYPE html>\n<html>\n")
        f.write("<head>\n")
        f.write("  <meta charset=\"utf-8\">\n")
        f.write("  <title>Signatures for #{url}</title>")
        if pgp.has_key?('css')
          f.write("  <link rel=\"stylesheet\" href=\"#{pgp['css']}\">\n")
        end
        f.write("</head>\n<body><div class=\"signatures\">\n")
        f.write("<h3>Signatures for <a href=\"#{url}\">#{url}</a></h3>\n")
        f.write("<p>Used key: <a href=\"#{pgp['key-url']}\">#{pgp['key-id']}</a><br/>\n")
        f.write("<b>Note:</b> There is no real security unless you verify that the" +
                            " public key you have matches the private key the site" +
                            " owner uses!</p>\n")
        f.write("<table>\n<tr><th>File</th><th>Signature</th></tr>\n")
        files.each { |file|
          f.write("  <tr><td><a href=\"#{file}\">#{file}</a></td>" +
                  "<td><a href=\"/#{pgp['target']}#{sigfile(file)}\">_.sig</a></td></tr>\n")
        }
        f.write("</table>\n</div></body>\n</html>")
      }
      site.keep_files << "#{site.dest.to_s}/#{siglist(url)}"
    end
    
    public
    def self.reset
      @@tosign = []
    end
    
    def self.enqueue(site, page, pgp)
      @@tosign.push([site, page, pgp])
      siglist(page)
    end
    
    def self.process
      Jekyll.logger.info("Signing files...")
      @@tosign.each { |a|
        site,url,pgp = a

        # Create signature file
        sign(site, url, pgp)
        
        # If the url pointed to a page, deal with linked files
        if find_file(site, url).end_with?(".html")
          # Extract linked assets, fonts and CSS and queue them
          linked = []
          
          File.open("#{find_file(site, url)}", "r") { |f|
            html = f.readlines.join("\n")
            # TODO extend and/or make configurable
            linked = html.scan(/(href|src)=["'](\/(fonts|assets|css)\/.*?)["']/)\
                         .map { |m| m[1] }
          }
          linked.uniq!
          
          linked.each { |lfile| 
            sign(site, lfile, pgp)
          }
          
          # Create signature page
          files = [url] + linked
          create_siglist(site, url, pgp, files)
        end
      }
    end
  end
  
  class PgpSign < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      site = context.registers[:site]
      page = context['page']['url']
      pgp  = context['site']['pgp']

      sigpage = PgpService.enqueue(site, page, pgp)
      "<span class='pgp-sign-note'>This page has been <a href=\"#{sigpage}\">signed with PGP</a>.</span>"
    end
  end
end

Liquid::Template.register_tag('sign', Jekyll::PgpSign)

Jekyll::Hooks.register :site, :after_reset do |site|
  Jekyll::PgpService.reset
end
Jekyll::Hooks.register :site, :post_write do |post|
  Jekyll::PgpService.process
end
