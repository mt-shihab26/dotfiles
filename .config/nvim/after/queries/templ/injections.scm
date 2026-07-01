; extends

; AlpineJS attributes (x-*)
(attribute
  (attribute_name) @_attr
    (#lua-match? @_attr "^x%-%l")
    (#not-any-of? @_attr "x-teleport" "x-ref" "x-transition")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

; AlpineJS attributes (@*)
(attribute
  (attribute_name) @_attr
    (#lua-match? @_attr "^@%l")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

