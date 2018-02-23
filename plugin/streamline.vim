" ==============================================================================
" streamline.vim
" ==============================================================================
" Version:       1.1.0
" Author:        Charles E. Sheridan
" Script:        https://vim.sourceforge.io/scripts/index.php
" Documention:   https://raw.githubusercontent.com/cesheridan/streamline.vim/master/README.md
" License:       GPL (Gnu Public License) version 3


" ==============================================================================
"  PLUGIN MGT
" ==============================================================================
let g:streamline_version                             = '2.0.0'


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

" ==============================================================================
"--- NAVIGATION 2 WINDOW-N 
" ==============================================================================
noremap <silent>  <Leader><Leader>1  :1wincmd w<CR>
noremap <silent>  <Leader><Leader>2  :2wincmd w<CR>
noremap <silent>  <Leader><Leader>3  :3wincmd w<CR>
noremap <silent>  <Leader><Leader>4  :4wincmd w<CR>
noremap <silent>  <Leader><Leader>5  :5wincmd w<CR>
noremap <silent>  <Leader><Leader>6  :6wincmd w<CR>
noremap <silent>  <Leader><Leader>7  :7wincmd w<CR>
noremap <silent>  <Leader><Leader>8  :8wincmd w<CR>
noremap <silent>  <Leader><Leader>9  :9wincmd w<CR>
noremap <silent> <Leader><Leader>10 :10wincmd w<CR>
noremap <silent> <Leader><Leader>11 :11wincmd w<CR>
noremap <silent> <Leader><Leader>12 :12wincmd w<CR>
noremap <silent> <Leader><Leader>13 :13wincmd w<CR>
noremap <silent> <Leader><Leader>14 :14wincmd w<CR>
noremap <silent> <Leader><Leader>15 :15wincmd w<CR>
noremap <silent> <Leader><Leader>16 :16wincmd w<CR>
noremap <silent> <Leader><Leader>17 :17wincmd w<CR>
noremap <silent> <Leader><Leader>18 :18wincmd w<CR>
noremap <silent> <Leader><Leader>19 :19wincmd w<CR>
noremap <silent> <Leader><Leader>20 :20wincmd w<CR>

" ==============================================================================
function!  Win_getid_for_statusline() 
    return 'w' . win_getid()
endfunction
" ==============================================================================
function!  Super_mode()
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
function!  Statusline_begin()
" ==============================================================================
  return winnr().'-'.bufnr("%").' '.Super_mode() 
  " scan the windows in the tab -- in that context the nums at bottom left of
  " each window imply it's the window number.
  " 2nd num likely a buffer#, which is the key relation that a window 
  " has, & '-' indicates the tightness of the relation
endfunction
" ==============================================================================
function!  Statusline_middle_editwin()

  return (&buftype == 'terminal') 
  \ ? '' 
  \ :   getbufvar(bufnr('%'),'&mod')        ?  '[+]' : '' .
  \     getbufvar(bufnr('%'),'&modifiable') ?  ''    : '[READ-ONLY]'
  " don't want to see this in terminals

endfunction
" ==============================================================================
function!  Statusline_end_editwin()

  return (&buftype                                    ==  'terminal') 
  \   || (g:streamline_external_components_are_wanted ==? 'N'       )
  \ ? '' 
  \ : ' '.Tlist_Get_Tagname_By_Line().' '.fugitive#statusline()

endfunction
" ==============================================================================
function!  Statusline_timestamp()

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
set statusline+=\%{Statusline_begin()}
" line begins w/ relativley static, identifying content

set statusline+=\ %4l\/%L\ %2cC 
" 'noisy' content in the middle -- less distrction than if at left or right
" '4' & '2': line# & col# padding, less jarring when nums update
" '/' in i/j ids this as line#/total
" that the num is a Col# is less apparent, so 'C', which also implies i/j is rows
                                 
set statusline+=\ %{Win_getid_for_statusline()}
set statusline+=\ %t " filename
" omit path of file -- takes up too much space, usually of Secondary interest
" Add it to title string if visibility desired.
set statusline+=\ 

set statusline+=\%<  " right justify the following entries 
set statusline+=\%{Statusline_middle_editwin()}
set statusline+=\%h " Help ?
set statusline+=\%q " Quickfix ?
set statusline+=\%w " Preview ?

set statusline+=\ %=
set statusline+=\%{Statusline_end_editwin()}
" Secondary content: put at left side of RHS content

set statusline+=\%{Statusline_timestamp()}
" HMS, the most granular part of the timestamp, at far-right for max visibility
" on RHS: in real-time this is usually of greater interest than Tzone YMDate
"OLD: set statusline+=\%{toupper(strftime(\"%r\ %a-%d%b\"))}
