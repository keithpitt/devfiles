" Vim indent file
" Language: wf2 (workflow2)
" Maintainer: Keith Pitt

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal autoindent
setlocal indentexpr=GetWf2Indent()
setlocal indentkeys=0{,0},0),!^F,o,O,e,0=else,0=},0=case,0=default,0=catch

" Only define the function once
if exists("*GetWf2Indent")
  finish
endif

function! GetWf2Indent()
  let lnum = prevnonblank(v:lnum - 1)

  " At the start of the file, no indent
  if lnum == 0
    return 0
  endif

  let prevline = getline(lnum)
  let currline = getline(v:lnum)
  let ind = indent(lnum)

  " Indent after lines ending with {
  if prevline =~ '{\s*$'
    let ind += shiftwidth()
  endif

  " Indent after if, foreach, match, try without { on same line
  if prevline =~ '^\s*\(if\|foreach\|match\|try\)\s' && prevline !~ '{\s*$'
    let ind += shiftwidth()
  endif

  " Indent after case/default lines
  if prevline =~ '^\s*\(case\|default\)\s' && prevline !~ '{\s*$'
    let ind += shiftwidth()
  endif

  " Indent after else, catch
  if prevline =~ '^\s*\(else\|catch\)\s' && prevline !~ '{\s*$'
    let ind += shiftwidth()
  endif

  " De-indent for closing }
  if currline =~ '^\s*}'
    let ind -= shiftwidth()
  endif

  " De-indent for else, catch on current line
  if currline =~ '^\s*\(else\|catch\)\>'
    let ind -= shiftwidth()
  endif

  " De-indent for case/default
  if currline =~ '^\s*\(case\|default\)\>'
    let ind -= shiftwidth()
  endif

  " Ensure we don't go below 0
  if ind < 0
    let ind = 0
  endif

  return ind
endfunction
