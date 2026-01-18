; extends

(directive) @keyword
(directive_start) @keyword
(directive_end) @keyword
(comment) @comment
((bracket_start) @punctuation.special (#set! "priority" 120))
((bracket_end) @punctuation.special (#set! "priority" 120))
(keyword) @keyword

