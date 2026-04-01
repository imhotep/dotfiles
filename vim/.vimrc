set et
set shiftwidth=2
set tabstop=2
syntax on
set nu

" ==================== Clipboard over SSH (your original) ====================
if !empty($SSH_TTY)
  set clipboard=unnamedplus

  " Fallback OSC 52 function
  function! Osc52Yank()
    let buffer = system('base64 -w0', @0)
    let buffer = substitute(buffer, "\n$", "", "")
    let buffer = '\e]52;c;' . buffer . '\x07'
    silent exe "!echo -ne '" . buffer . "' > " . shellescape($SSH_TTY)
  endfunction

  augroup osc52
    autocmd!
    autocmd TextYankPost * if v:event.operator == 'y' | call Osc52Yank() | endif
  augroup END
endif

" ==================== Paste mode (prevents indentation mess) ====================
" Toggle paste mode easily (recommended way)
set pastetoggle=<F2>

" Optional: Also map it to a leader key for convenience
nnoremap <leader>p :set paste!<CR>:set paste?<CR>

" ==================== Commenting without plugin ====================
" Define comment leader per file type
augroup comment_leader
  autocmd!
  autocmd FileType vim       let b:comment_leader = '" '
  autocmd FileType sh,bash,zsh,python,ruby,conf,yaml,json let b:comment_leader = '# '
  autocmd FileType c,cpp,java,go,javascript,typescript let b:comment_leader = '// '
  autocmd FileType html,xml,markdown let b:comment_leader = '<!-- '
  autocmd FileType css       let b:comment_leader = '/* '
  autocmd FileType sql       let b:comment_leader = '-- '
  autocmd FileType lua       let b:comment_leader = '-- '
  autocmd FileType tex       let b:comment_leader = '% '
augroup END

" Toggle comment function
function! ToggleComment() range
  if !exists('b:comment_leader')
    echo "No comment leader defined for this filetype"
    return
  endif

  let l:leader = escape(b:comment_leader, '/')

  for lnum in range(a:firstline, a:lastline)
    let line = getline(lnum)
    if line =~ '^\s*' . l:leader
      " Uncomment
      call setline(lnum, substitute(line, '^\s*' . l:leader . '\?', '', ''))
    else
      " Comment
      call setline(lnum, substitute(line, '^\s*', '&' . b:comment_leader, ''))
    endif
  endfor

  nohlsearch
endfunction

" Key mappings - gcc style (like vim-commentary)
nnoremap <silent> gcc :call ToggleComment()<CR>
vnoremap <silent> gc  :call ToggleComment()<CR>

" Bonus convenient mappings
nnoremap <silent> <C-/> :call ToggleComment()<CR>
nnoremap <silent> <leader>c :call ToggleComment()<CR>
vnoremap <silent> <C-/> :call ToggleComment()<CR>
vnoremap <silent> <leader>c :call ToggleComment()<CR>
