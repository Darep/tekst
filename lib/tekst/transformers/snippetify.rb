require 'tekst/transformers/snippetify/plain_text'

module Tekst
  module Transformers
    class Snippetify
      attr_accessor :opts

      def self.html_snippet(html, opts = {})
        default_opts!(opts)

        if opts[:length]
          snippet = HTML_Truncator.truncate(html, opts[:length], opts)
          was_truncated = snippet.html_truncated?
        else
          snippet = html
          was_truncated = false
        end

        snippet.strip!

        # Add is_truncated?
        eval "class <<snippet; def is_truncated?; #{!!was_truncated} end end"

        return snippet
      end

      def self.text_snippet(html, opts = {})
        default_opts!(opts)
        PlainText.snippet(html, opts)
      end

      private

        def self.default_opts!(opts)
          opts[:length_in_chars] ||= false
          opts[:ellipsis] ||= ''
        end

    end
  end
end
