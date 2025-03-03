colorscheme murphy
" indentation of course
filetype plugin indent on
" show lines"
set nu
" syntax colors"
syntax on
set re=0
"let g:javascript_plugin_jsdoc = 1
"let g:javascript_plugin_ngdoc = 1
"let g:javascript_plugin_flow = 1
set laststatus=2
set ruler " this shows status bar with line number
set mouse=a "this makes the mouse work in text mode
set hlsearch " this highlights search results
set expandtab " spaces instead of tabs
set shiftwidth=4 " tab size
set tabstop=4

set noswapfile
" Quoting/unquoting words
" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
" " double "quote" a word
nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl
" " remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>
nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>m :GFilesMonorepo<CR>
nnoremap <silent> <Leader>s :Ag<CR>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" File Browsing
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" make system clipboard work everywhere"
set clipboard^=unnamed,unnamedplus

" ale and airline
"let g:airline#extensions#ale#enabled = 1

map <Leader>cc :cwindow<CR>:cc<CR><c-w>bz<CR><CR>
" \cn
map <Leader>cn :cwindow<CR>:cn<CR><c-w>bz<CR><CR>
" \cp
map <Leader>cp :cwindow<CR>:cp<CR><c-w>bz<CR><CR>

" close buffer without closing window
map <leader>q :bp\|bd #<CR>

" close buffer without closing window
map <leader>f :Files <CR>

" buffers
nnoremap <Leader>b :buffers<CR>:b<Space>

" Make backspace work in insert mode 
set backspace=2

" Format JSON
command! FormatJSON %!python -m json.tool

" Keep history when changing buffers
set hidden

" File browsing
set wildmenu
set wildmode=longest:full,full

" syntax highlighting for mustache templates
"au BufReadPost *.mustache set syntax=html
au BufNewFile,BufRead *.ejs set filetype=html

" set laststatus=2
" set statusline=%f "tail of the filename

"set rtp+=/usr/local/opt/fzf,/usr/bin/fzf
set rtp+=/opt/homebrew/opt/fzf
" Specify a directory for plugins
 " - For Neovim: stdpath('data') . '/plugged'
 " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'hashivim/vim-terraform'
call plug#end()


" coc.vim config
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-pairs', 'coc-go', 'coc-prettier']
set encoding=utf-8
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Trigger completion with tab
inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
noremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" "set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Coc GO add missing imports on save
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

au BufEnter *.ts :Copilot enable

" ported from https://github.com/junegunn/fzf.vim/blob/master/autoload/fzf/vim.vim#L546
function! s:get_git_root()
  let l:root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  if v:shell_error
      return ''
  endif
  return l:root
endfunction

function! s:gitfiles_monorepo()
  let l:root = s:get_git_root()
  let l:path = substitute(getcwd(), l:root, '', '')
  let l:path = substitute(l:path, '/', '', '')

  let l:options = '-m --preview "head -20 {1}" --prompt "GitFiles> " '
  if l:path != ''
    let l:options .= '--query '.l:path
  endif

  call fzf#run({
  \ 'source':  'git ls-files | uniq',
  \ 'sink': 'e',
  \ 'dir': l:root,
  \ 'options': l:options,
  \ 'down':    '40%'
  \})
endfunction
command! GFilesMonorepo call s:gitfiles_monorepo()

inoremap <silent><expr> <c-space> coc#refresh()

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

highlight CocErrorFloat ctermfg=White guifg=#ffffff
" hi! CocErrorSign guifg=#d1666a
" hi! CocInfoSign guibg=#353b45
" hi! CocWarningSign guifg=#d1cd66
let g:fzf_history_dir = '~/.local/share/fzf-history'
