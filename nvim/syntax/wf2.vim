if exists("b:current_syntax")
  finish
endif

" Annotations (can appear anywhere, have optional args and block)
syn match wf2Annotation "@[a-zA-Z_][a-zA-Z0-9_-]*"

" Comments
syn match wf2Comment "#.*$" contains=@Spell

" Strings (before other patterns to take precedence)
syn region wf2String start=/"/ end=/"/ skip=/\\"/ contains=wf2StringEscape
syn region wf2StringTriple start=/"""/ end=/"""/
syn match wf2StringEscape /\\[\\tnr"]/ contained

" Regex literals
syn region wf2Regex start=+/+ end=+/+ skip=+\\/+

" Numbers
syn match wf2Number "\<\d\+\>"
syn match wf2Number "\<\d\+\.\d\+\>"

" Keywords
syn keyword wf2Keyword if else foreach as try catch call return break raise yields
syn keyword wf2Boolean true false
syn keyword wf2Null null

" Operators (symbol operators)
syn match wf2Operator "=~"
syn match wf2Operator "=="
syn match wf2Operator "!="
syn match wf2Operator ">="
syn match wf2Operator "<="
syn match wf2Operator ">"
syn match wf2Operator "<"
syn match wf2Operator "&&"
syn match wf2Operator "||"
syn match wf2Operator "!"

" Variables with property paths (no $ prefix, but must not be followed by /)
syn match wf2Variable "\<[a-zA-Z_][a-zA-Z0-9_-]*\>\ze\(\.\|\_s\|)\|}\|,\|;\)" nextgroup=wf2PropertyPath
syn match wf2PropertyPath "\.[a-zA-Z_][a-zA-Z0-9_-]*" nextgroup=wf2PropertyPath

" Special variable
syn match wf2SpecialVar "\<_position\>"

" Function calls (namespace/path/name syntax)
syn match wf2Function "[a-zA-Z_][a-zA-Z0-9_-]*/[a-zA-Z0-9_/-]*"

" Object keys (both quoted and unquoted)
syn match wf2ObjectKey /"[^"]*"\s*:/ contains=wf2String
syn match wf2ObjectKey /\<[a-zA-Z_][a-zA-Z0-9_-]*?\?\s*:/


" Delimiters
syn match wf2Delimiter "[{}()\[\],:]"

" Highlighting
hi def link wf2Annotation PreProc
hi def link wf2Comment Comment
hi def link wf2Keyword Keyword
hi def link wf2Boolean Boolean
hi def link wf2Null Constant
hi def link wf2Variable @lsp.type.variable
hi def link wf2PropertyPath @lsp.type.variable
hi def link wf2SpecialVar Special
hi def link wf2Function Function
hi def link wf2String String
hi def link wf2StringTriple String
hi def link wf2StringEscape SpecialChar
hi def link wf2Regex String
hi def link wf2Number Number
hi def link wf2Operator Operator
hi def link wf2ObjectKey Identifier
hi def link wf2Delimiter Delimiter

let b:current_syntax = "wf2"
