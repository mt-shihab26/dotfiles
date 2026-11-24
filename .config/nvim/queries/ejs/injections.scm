; same as embedded_template's, with javascript in the tags instead of ruby
((content) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))

((code) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.combined))
