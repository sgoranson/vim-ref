let s:save_cpo = &cpo
set cpo&vim

if !exists('g:ref_alc_start_linenumber')
  let g:ref_alc_start_linenumber = 33
endif

if !exists('g:ref_alc_open')
  let g:ref_alc_open = 'split'
endif

if !exists('g:ref_alc_history_num')
  let g:ref_alc_history_num = 5
endif

if !exists('g:ref_alc_open_cmd')
  let g:ref_alc_open_cmd = 
  \ executable('elinks') ? 'elinks -dump -no-numbering -no-references %s' :
  \ executable('w3m')    ? 'w3m -dump %s' :
  \ executable('links')  ? 'links -dump %s' :
  \ executable('lynx')   ? 'lynx -dump -nonumbers %s' :
  \ ''
endif

function! ref#alc#available()
  return g:ref_alc_open_cmd != '' 
endfunction

function! ref#alc#get_body(query)
  return system(printf(g:ref_alc_open_cmd, '"http://eow.alc.co.jp/'.a:query.'/UTF-8/?ref=sa"'))
endfunction

function! ref#alc#opened(query)
  execute "normal! ".g:ref_alc_start_linenumber."z\<CR>"
endfunction

function! ref#alc#complete(query)
endfunction

function! ref#alc#get_keyword()
  return expand('<cword>')
endfunction

function! ref#alc#leave()
endfunction

call ref#detect#register('alc', 'alc')

let &cpo = s:save_cpo
unlet s:save_cpo
