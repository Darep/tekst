Changelog
=========

## 0.0.1

Initial release.

#### New features

- Create HTML snippets from HTML with `Tekst.html_snippet(html)`
- Create plain text snippets from HTML with `Tekst.text_snippet(html)
- Process HTML with `Tekst.process(html)`:
  - Transforms identified `<pre>` elements into CodeRay syntax hilighted code blocks
  - Beautifies HTML using [Typogruby](http://avdgaag.github.io/typogruby/)
  - Auto links URLs and email addresses in HTML into anchor links using [Rinku](https://github.com/vmg/rinku)
