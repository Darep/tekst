require 'sanitize'

module Tekst
  class PlainText
    def self.snippet(html, opts = {})
      snippet = process(html)

      if opts[:length]
        snippet = truncate(snippet, opts[:length], opts[:ellipsis], opts[:length_in_chars])
      end

      unless snippet.respond_to? :is_truncated?
        eval "class <<snippet; def is_truncated?; false end end"
      end

      return snippet
    end

    private

      def self.process(html)
        # Remove all HTML elements
        snippet = sanitize(html)

        # Remove line breaks
        snippet.gsub!(/[\r\n]/, '')

        # Remove multiple spaces
        snippet.gsub!(/(\s\s+)/, ' ')

        # Remove all sorts of spaces from the beginning of string
        snippet.gsub!(/\A[\u200b\u203b\s]+/, '')

        # Remove whitespace from start and end
        snippet.strip!
      end

      def self.sanitize(html)
        Sanitize.fragment(html)
      end

      def self.truncate(snippet, length, ellipsis, length_in_chars)
        if length < snippet.length
          if length_in_chars
            snippet = snippet[0..(length - 1)].strip
          else
            words = snippet.split  # split to words array
            snippet = words[0..(length - 1)].join(' ')
          end

          # Add is_truncated?
          eval "class <<snippet; def is_truncated?; true end end"
        end

        return snippet
      end

  end
end
