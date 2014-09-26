module Tekst
  module Transformers
    Codify = lambda do |env|
      fragment = Nokogiri::HTML::fragment(env[:html])

      fragment.xpath('.//pre/code').each do |node|
        css_classes = [node.parent['class']]

        begin
          lang = node['data-lang'] || ''
          css_classes << 'CodeRay' << "CodeRay--#{lang.to_s}"

          code = CodeRay.scan(node.content, lang.to_sym).html
          node.children = code
        rescue ArgumentError => e
          # Add info that no lang given or not known by CodeRay
          css_classes << 'CodeRay--unknown-lang'
        end

        node.parent['class'] = css_classes.join(' ')
      end

      return fragment.to_html
    end
  end
end
