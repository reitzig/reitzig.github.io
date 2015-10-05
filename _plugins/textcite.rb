module Jekyll
  class Scholar
    module Utilities
          
      def textcite(keys)
        keys.uniq!
        
        names = keys.map do |key|
          if bibliography.key?(key)
            entry = bibliography[key]
            entry = entry.convert(*bibtex_filters) unless bibtex_filters.empty?
            firstname = entry.author[0].to_s.split(",")[0] 

            if entry.author.length > 2
              "#{firstname}&nbsp;et&#8239;al.&nbsp;#{cite([key])}"
            elsif entry.author.length == 2
              "#{firstname} and #{entry.author[1].to_s.split(",")[0]}&nbsp;#{cite([key])}"
            else
              "#{firstname}&nbsp;#{cite([key])}"
            end
          else
            return missing_reference
          end 
        end
        
        if names.length == 1
          names[0]
        elsif names.length == 2
          "#{names[0]} and #{names[1]}"
        else
          names.join(", ").reverse.sub(" ,", " dna ,").reverse
        end
      end
    end
    
    class TextciteTag < Liquid::Tag
      include Scholar::Utilities
      
      attr_reader :pages
      
      def initialize(tag_name, arguments, tokens)
        super
        
        @config = Scholar.defaults.dup
        @keys, arguments = split_arguments(arguments)

        optparse(arguments)
      end

      def render(context)
        set_context_to context
        textcite @keys
      end
    end
  end
end

Liquid::Template.register_tag('textcite', Jekyll::Scholar::TextciteTag)
