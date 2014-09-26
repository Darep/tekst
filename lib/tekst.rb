require 'html_truncator'
require 'tekst/transformers/auto_link'
require 'tekst/transformers/codify'
require 'tekst/transformers/snippetify'
require 'tekst/transformers/typogruby'
require 'tekst/version'

module Tekst
  def self.html_snippet(html, opts = {})
    transformer = lambda do |env|
      Transformers::Snippetify.html_snippet(env[:html], opts)
    end

    transform(html, [transformer])
  end

  def self.process(html, opts = {})
    transformers = [
      Transformers::Codify,
      Transformers::AutoLink,
      Transformers::Typogruby
    ]

    transform(html, transformers)
  end

  def self.text_snippet(html, opts = {})
    transformer = lambda do |env|
      Transformers::Snippetify.text_snippet(env[:html], opts)
    end

    transform(html, [transformer])
  end

  def self.transform(html, transformers)
    raise 'undefined or empty `html´ passed to Tekst.transform' if html.nil? or html.empty?

    transformers.each do |transformer|
      if transformer.is_a? String
        transformer.safe_constantize
      end

      html = transformer.call(html: html)
    end

    return html
  end

end
