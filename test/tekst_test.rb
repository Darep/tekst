require 'minitest_helper'

class TekstTest < MiniTest::Test

  describe '#html_snippet' do
    before do
      @long_html_example = <<-HTML.gsub(/^ {8}/, '')
        <p>Curabitur blandit tempus porttitor. Praesent commodo cursus magna,
        vel scelerisque nisl consectetur et. Fusce dapibus, tellus ac cursus
        commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit
        amet risus.</p>
        <p>Vestibulum id ligula porta felis euismod semper. Cum sociis
        natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
        Vestibulum id ligula porta felis euismod semper.</p>
      HTML
    end

    it 'should add is_truncated? to the returned object' do
      snippet = Tekst.html_snippet('<p></p>')
      assert snippet.respond_to? :is_truncated?
    end

    it 'should truncate html' do
      snippet = Tekst.html_snippet(@long_html_example, length: 4)
      assert_equal '<p>Curabitur blandit tempus porttitor</p>', snippet
    end

    it 'should truncate html in characters' do
      snippet = Tekst.html_snippet(@long_html_example, length: 9, length_in_chars: true)
      assert_equal '<p>Curabitur</p>', snippet
    end

    it 'should return html as is when no length is specified' do
      snippet = Tekst.html_snippet(@long_html_example)
      assert_equal @long_html_example, snippet
    end

    it 'should accept and add ellipsis to truncated html' do
      snippet = Tekst.html_snippet(@long_html_example, length: 2, ellipsis: '...')
      assert_match /\.\.\.<\/p>\Z/, snippet
    end

    it 'should say html was truncated' do
      snippet = Tekst.html_snippet(@long_html_example, length: 20)
      assert snippet.is_truncated?
    end

    it 'should say html was not truncated' do
      snippet = Tekst.html_snippet(@long_html_example, length: 9999)
      assert !snippet.is_truncated?
    end
  end

  describe '#text_snippet' do
    before do
      @short_html_example = <<-HTML.gsub(/^ {8}/, '')
        <p>Etiam porta sem malesuada magna mollis euismod.</p>
        <p>Sed posuere consectetur est at lobortis.</p>
      HTML
    end

    it 'should return plain text for html' do
      snippet = Tekst.text_snippet(@short_html_example)
      assert_equal 'Etiam porta sem malesuada magna mollis euismod. Sed posuere consectetur est at lobortis.', snippet
    end

    it 'should truncate if length is specified' do
      snippet = Tekst.text_snippet(@short_html_example, length: 2)
      assert_equal 'Etiam porta', snippet
    end

    it 'should truncate if length is specified in characters' do
      snippet = Tekst.text_snippet(@short_html_example, length: 11, length_in_chars: true)
      assert_equal 'Etiam porta', snippet
    end
  end

  describe '#process' do
    before do
      @short_html_example = <<-HTML.gsub(/^ {8}/, '')
        <p>Etiam porta sem malesuada magna mollis euismod.</p>
        <p>Sed posuere consectetur est at lobortis.</p>
      HTML
    end

    it 'should add CodeRay classes for code blocks' do
      skip 'test pending'
      html = Tekst.process(@short_html_example)
    end

    it 'should auto link URLs in HTML' do
      html = Tekst.process('<p>Something something http://ajk.fi/ and so on.</p>')
      assert_match /<a href="http:\/\/ajk\.fi\/">http:\/\/ajk\.fi\/<\/a>/, html
    end

    it 'should auto link email address in HTML' do
      html = Tekst.process('<p>Something something ajk@ajk.fi and so on.</p>')
      assert_match /<a href="mailto:ajk@ajk\.fi">ajk@ajk\.fi<\/a>/, html
    end

    it 'should responsify YouTube embed' do
      skip 'test pending'
      html = Tekst.process(@short_html_example)
    end
  end
end
