; extends

((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))

((text) @injection.content
    (#has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language bash))

; PHP blocks with <?php ?> tags - use php_only for content inside tags
((php_only) @injection.content
    (#set! injection.combined)
    (#set! injection.language php_only))

((parameter) @injection.content
    (#set! injection.language php_only))
