
function! Smart_TabComplete()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.')+1)      " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()




" An example for a vimrc file.
" "
" " Maintainer:	Bram Moolenaar <Bram@vim.org>
" " Last change:	2008 Dec 17
" "
" " To use it, copy it to
" "     for Unix and OS/2:  ~/.vimrc
" "	      for Amiga:  s:.vimrc
" "  for MS-DOS and Win32:  $VIM\_vimrc
" "	    for OpenVMS:  sys$login:.vimrc
"
" " When started as "evim", evim.vim will already have done these settings.
" if v:progname =~? "evim"
"   finish
"   endif
"
"   " Use Vim settings, rather than Vi settings (much better!).
"   " This must be first, because it changes other options as a side effect.
   set nocompatible
"
"   " allow backspacing over everything in insert mode
   set backspace=indent,eol,start
"
   if has("vms")
     set nobackup		" do not keep a backup file, use versions
     instead
     else
       set backup		" keep a backup file
       endif
       set history=50		" keep 50 lines of command line history
       set ruler		" show the cursor position all the time
       set showcmd		" display incomplete commands
       set incsearch		" do incremental searching

"       " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu
"       entries
"       " let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
" map Q gq
"
" " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" " so that you can undo CTRL-U after inserting a line break.
 inoremap <C-U> <C-G>u<C-U>
"
" " In many terminal emulators the mouse works just fine, thus enable it.
 if has('mouse')
   set mouse=a
   endif
"
"   " Switch syntax highlighting on, when the terminal has colors
"   " Also switch on highlighting the last used search pattern.
   if &t_Co > 2 || has("gui_running")
     syntax on
       set hlsearch
       endif

"       " Only do this part when compiled with support for autocommands.
       if has("autocmd")

"         " Enable file type detection.
"           " Use the default filetype settings, so that mail gets 'tw' set to
"           72,
"             " 'cindent' is on in C files, etc.
"               " Also load indent files, to automatically do
"               language-dependent indenting.
                 filetype plugin indent on
"
"                   " Put these in an autocmd group, so that we can delete
"                   them easily.
                     augroup vimrcEx
                       au!
"
"                         " For all text files set 'textwidth' to 78
"                         characters.
                           autocmd FileType text setlocal textwidth=78
"
"                             " When editing a file, always jump to the last
"                             known cursor position.
"                               " Don't do it when the position is invalid or
"                               when inside an event handler
"                                 " (happens when dropping a file on gvim).
"                                   " Also don't do it when the mark is in the
"                                   first line, that is the default
"                                     " position when opening a file.
                                       autocmd BufReadPost *
                                           \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" " file it was loaded from, thus the changes you made.
" " Only define it when not defined already.
  if !exists(":DiffOrig")
   command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
   		  \ | wincmd p | diffthis
   		  endif

set number
set guifont=Monaco:h14

filetype plugin on
" au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType php set dictionary=~/.vim/syntax/php/php-dictionary.txt
au FileType php set makeprg=php\ -l\ %
au FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

let php_sql_query=1                                                                                        
let php_htmlInStrings=1

"set tags=~/.vim/mytags/puelia


" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif


let g:PreviewBrowsers='firefox -no-remote -new-window,links'
au FileType mkd set makeprg=bluecloth %
