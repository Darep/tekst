require 'typogruby'

module Tekst
  module Transformers
    Typogruby = lambda do |env|
      html = env[:html]
      ::Typogruby.improve(html)
    end
  end
end
