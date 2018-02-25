" ==============================================================================
" streamline.vim
" ==============================================================================
" Version:       1.2.0
" Author:        Charles E. Sheridan
" Script:        https://vim.sourceforge.io/scripts/script.php?script_id=5660
" Documention:   https://raw.githubusercontent.com/cesheridan/streamline.vim/master/README.md
" License:       GPL (Gnu Public License) version 3


" ==============================================================================
"  PLUGIN MGT
" ==============================================================================
let g:streamline_version                             = '1.2.0'


" ==============================================================================
" CONFIGS - VIM-GLOBAL g: 
" ==============================================================================
" ---         streamline_external_components_are_wanted

if !exists("g:streamline_external_components_are_wanted_default")
  let       g:streamline_external_components_are_wanted_default  =  'N'
endif

if !exists("g:streamline_external_components_are_wanted")
  let       g:streamline_external_components_are_wanted
  \ =       g:streamline_external_components_are_wanted_default      
endif

" ---         streamline_timestamp_is_wanted

if !exists("g:streamline_timestamp_is_wanted_default")
  let       g:streamline_timestamp_is_wanted_default  =  'Y'
endif

if !exists("g:streamline_timestamp_is_wanted")
  let       g:streamline_timestamp_is_wanted
  \ =       g:streamline_timestamp_is_wanted_default      
endif

" ---         streamline_highest_window_map_number

if !exists("g:streamline_highest_window_map_number")
  let       g:streamline_highest_window_map_number = 100
endif

" ---         streamline_map_name_prefix
if !exists("g:streamline_map_name_prefix")
  let       g:streamline_map_name_prefix = '<Leader><Leader>'
endif
" ==============================================================================
function! streamline#build_navigation_maps(rcvd_hash) 
" ==============================================================================
  let                           l:rcvd_hash = extend ({
  \  'map_name_prefix' : g:streamline_map_name_prefix,
  \  },
  \                    deepcopy(a:rcvd_hash,1)
  \)
  for l:window_number in range(1, g:streamline_highest_window_map_number)

   "let l:map_name = '<Leader><Leader>'   .  l:window_number
    let l:map_name = l:rcvd_hash['map_name_prefix'].l:window_number
    "e.g. '<Leader><Leader>5'

    let l:cmd_rhs  = ':'.l:window_number.'wincmd w' 
    "e.g. ':5wincmd w'

    " ------------------------------------------------------------------
    let     l:execute_arg = 'noremap <silent> '.l:map_name.' ' .l:cmd_rhs.'<CR>'
    execute l:execute_arg
    " ------------------------------------------------------------------
    "  e.g.  noremap <silent>  <Leader><Leader>5  :5wincmd<CR>
  endfor
endfunction
" ------------------------------------------------------------------------------
command! BuildNavigationMaps
\ :call  streamline#build_navigation_maps({})
" ------------------------------------------------------------------------------
        :BuildNavigationMaps
" ==============================================================================
function! streamline#win_getid_for_statusline() 
    return 'w' . win_getid()
endfunction
" ==============================================================================
function! streamline#super_mode()
" ==============================================================================
" Returns  'I' if INSERT
" Returns ' N' if NORMAL
" Returns 'TN' if TERMINAL-Normal
" Returns 'TJ' if TERMINAL-Job
"
" these identifiers are commonly known -- e.g. 'NORMAL' is OVERKILL

  if &buftype == 'terminal' 
    let l:term_getstatus = term_getstatus(bufnr("%"))

    let l:terminal_status_qualifier
    \= substitute(l:term_getstatus, "running\,normal", 'N', 'g')

    let l:terminal_status_qualifier  
    \= substitute(l:terminal_status_qualifier, 'running', 'J', 'g')

    " No change if 'finished'

    return 'T'.l:terminal_status_qualifier 
  else
    return toupper(mode())
  endif
endfunction
" ==============================================================================
function! streamline#begin()
" ==============================================================================
  return winnr().'-'.bufnr("%").' '.streamline#super_mode()
  " scan the windows in the tab -- in that context the nums at bottom left of
  " each window imply it's the window number.
  " 2nd num likely a buffer#, which is the key relation that a window 
  " has, & '-' indicates the tightness of the relation
endfunction
" =============================================================================
function! streamline#middle_editwin()

  return (&buftype == 'terminal') 
  \ ? '' 
  \ :   getbufvar(bufnr('%'),'&mod')        ?  '[+]' : '' .
  \     getbufvar(bufnr('%'),'&modifiable') ?  ''    : '[READ-ONLY]'
  " don't want to see this in terminals

endfunction
" =============================================================================
function! streamline#end_editwin()

  return (&buftype                                    ==  'terminal') 
  \   || (g:streamline_external_components_are_wanted ==? 'N'       )
  \ ? '' 
  \ : ' '.Tlist_Get_Tagname_By_Line().' '.fugitive#statusline()

endfunction
" ==============================================================================
function! streamline#timestamp()

  return (&buftype                         ==  'terminal') 
  \   || (g:streamline_timestamp_is_wanted ==? 'N'       )
  \ ? '' 
  \ : '  '.toupper ( strftime("%Z %Y-%m-%d %a %Hh%m:%S") )

  " don't want timestamp in terminals -- the CLI may already have it
  " AND Vim tends to clutter up the statusline in TERMINAL-Job mode, 
  " where it puts the current CLI prompt
endfunction
" ==============================================================================
set statusline=
set statusline+=\%{streamline#begin()}
" line begins w/ relativley static, identifying content
" NOTE-DOC-VIM: for autoload funcs, statusline assignment context forces 
" 'script_name#' syntax combined w/ function DCL that repeats script name, 
" not just s: , e.g.
"    'function! script_name#func_name()'
" NOT:
"    'function! s:func_name()'
"
" ALSO '<SID>func_name()' syntax fails on calls from inside %{}

set statusline+=\ %4l\/%L\ %2cC 
" 'noisy' content in the middle -- less distrction than if at left or right
" '4' & '2': line# & col# padding, less jarring when nums update
" '/' in i/j ids this as line#/total
" that the num is a Col# is less apparent, so 'C', which also implies i/j is rows
                                 
set statusline+=\ %{streamline#win_getid_for_statusline()}
set statusline+=\ %t " filename
" omit path of file -- takes up too much space, usually of Secondary interest
" Add it to title string if visibility desired.
set statusline+=\ 

set statusline+=\%<  " right justify the following entries 
set statusline+=\%{streamline#middle_editwin()}
set statusline+=\%h " Help ?
set statusline+=\%q " Quickfix ?
set statusline+=\%w " Preview ?

set statusline+=\ %=
set statusline+=\%{streamline#end_editwin()}
" Secondary content: put at left side of RHS content

set statusline+=\%{streamline#timestamp()}
" HMS, the most granular part of the timestamp, at far-right for max visibility
" on RHS: in real-time this is usually of greater interest than Tzone YMDate
"OLD: set statusline+=\%{toupper(strftime(\"%r\ %a-%d%b\"))}
