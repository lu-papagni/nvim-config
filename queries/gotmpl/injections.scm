; extends

; Detects special gotmpl comments to set the embedded language
; with format `ft: <lang-name>`

(template
  (comment) @injection.language
  (#lua-match? @injection.language "^/%* ft: [%w%-_]+ %*/$")
  
  ; "/* ft: " 7 characters (trims start)
  ; " */"     3 characters (trims end)
  (#offset! @injection.language 0 7 0 -3)
  
  [
    (text) @injection.content

    ; Depth 1: inside a block (e.g. if, range, with, define)
    (_ (text) @injection.content)

    ; Depth 2: nested blocks (e.g. if inside another if)
    (_ (_ (text) @injection.content))

    ; Depth 3: deeply nested (e.g. range inside if inside define)
    (_ (_ (_ (text) @injection.content)))
  ]

  (#set! injection.combined)
)
