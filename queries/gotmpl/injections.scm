; extends

; Detects special gotmpl comments to set the embedded language
; with format `ft: <lang-name>`

(template
  (comment) @injection.language
  (#lua-match? @injection.language "^/%* ft: [%w%-_]+ %*/$")
  
  ; "/* ft: " 7 characters (trims start)
  ; " */"     3 characters (trims end)
  (#offset! @injection.language 0 7 0 -3)
  
  (text) @injection.content
  (#set! injection.combined)
)
