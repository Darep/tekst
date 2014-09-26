require 'rinku'

module Tekst
  module Transformers
    AutoLink = lambda do |env|
      return Rinku.auto_link(env[:html])
    end
  end
end
