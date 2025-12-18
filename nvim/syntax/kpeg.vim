if exists("b:current_syntax")                                                                                                   
  finish                                                                                                                        
endif                                                                                                                           

" Embed Ruby syntax                                                                                                             
syn include @Ruby syntax/ruby.vim                                                                                               

" Directives                                                                                                                    
syn match kpegDirective /^%%\s*\(name\|pre-class\)\s*=\?/                                                                       
syn region kpegDirectiveBlock matchgroup=kpegDirective start=/^%%\s*\(pre-class\)\?\s*{/ end=/^}/ contains=@Ruby keepend        

" Rule definitions                                                                                                              
syn match kpegRuleName /^\s*[a-zA-Z_][a-zA-Z0-9_-]*\s*\ze=/                                                                     

" Ruby action blocks                                                                                                            
syn region kpegAction matchgroup=kpegBrace start=/{/ end=/}/ contains=@Ruby keepend                                             

" Strings and regex                                                                                                             
syn region kpegString start=/"/ end=/"/ skip=/\\"/                                                                              
syn region kpegString start=/'/ end=/'/ skip=/\\'/                                                                              
syn region kpegRegex start=/\// end=/\// skip=/\\\// contained                                                                  

" Operators and syntax                                                                                                          
syn match kpegOperator /[=|*+?!&<>]/                                                                                            
syn match kpegLabel /:[a-zA-Z_][a-zA-Z0-9_]*/                                                                                   
syn match kpegComment /#.*$/ contains=@Spell                                                                                    

hi def link kpegDirective PreProc                                                                                               
hi def link kpegRuleName Function                                                                                               
hi def link kpegOperator Operator                                                                                               
hi def link kpegString String                                                                                                   
hi def link kpegRegex String                                                                                                    
hi def link kpegLabel Identifier                                                                                                
hi def link kpegComment Comment                                                                                                 
hi def link kpegBrace Delimiter                                                                                                 

let b:current_syntax = "kpeg"
