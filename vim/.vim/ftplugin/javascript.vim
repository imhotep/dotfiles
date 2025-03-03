" Fix formatting for JS
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

" prevent js files from being treated as jsx files
let g:jsx_ext_required = 1

" small changes for ESLINT ALE (aesthetic)
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" Fix files automatically on save
let g:ale_fix_on_save = 1


" Enable ESLint only for JavaScript.
let b:ale_linters = ['jshint']

" Equivalent to the above.
" let b:ale_linters = {'javascript': ['jshint']}
