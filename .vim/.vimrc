set relativenumber number
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ignorecase
set smartcase
set notimeout
set background=dark
set hidden

if empty(glob('~/.vim/autoload/plug.vim'))
  :exe '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =======================
" ===  plugins  begin ===
" =======================
call plug#begin('~/.vim/plugged')

" enhance editor
Plug 'tomtom/tcomment_vim'

" terminal
Plug 'skywind3000/vim-terminal-help'

" file explorer
Plug 'preservim/nerdtree'

" file finder
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

" debug
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-rust --enable-python'}

Plug 'tomasiser/vim-code-dark'

Plug 'vim-airline/vim-airline'

Plug 'morhetz/gruvbox'

Plug 'godlygeek/tabular'

Plug 'preservim/vim-markdown'

Plug 'frazrepo/vim-rainbow'

call plug#end()
" =======================
" ===   plugins  end  ===
" =======================
"
"
colorscheme molokai
let g:airline_theme = 'codedark'
set t_Co=256
set t_ut=
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:rainbow_active = 1
syntax enable
syntax on


" " ==== tomtom/tcomment_vim ====

let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<

" ==== preservim/nerdtree ====

nnoremap <LEADER>e :NERDTreeToggle<CR>

" ==== Yggdroot/LeaderF ====
let g:Lf_WindowPosition='right'
let g:Lf_PreviewInPopup=1
let g:Lf_CommandMap = {
\   '<C-p>': ['<C-k>'],
\   '<C-k>': ['<C-p>'],
\   '<C-j>': ['<C-n>']
\}
nmap <leader>f :Leaderf file<CR>
nmap <leader>b :Leaderf! buffer<CR>
nmap <leader>F :Leaderf rg<CR>
let g:Lf_DevIconsFont = "DroidSansMono Nerd Font Mono"


set termguicolors

" ==== jackguo380/vim-lsp-cxx-highlight ====

hi default link LspCxxHlSymFunction cxxFunction
hi default link LspCxxHlSymFunctionParameter cxxParameter
hi default link LspCxxHlSymFileVariableStatic cxxFileVariableStatic
hi default link LspCxxHlSymStruct cxxStruct
hi default link LspCxxHlSymStructField cxxStructField
hi default link LspCxxHlSymFileTypeAlias cxxTypeAlias
hi default link LspCxxHlSymClassField cxxStructField
hi default link LspCxxHlSymEnum cxxEnum
hi default link LspCxxHlSymVariableExtern cxxFileVariableStatic
hi default link LspCxxHlSymVariable cxxVariable
hi default link LspCxxHlSymMacro cxxMacro
hi default link LspCxxHlSymEnumMember cxxEnumMember
hi default link LspCxxHlSymParameter cxxParameter
hi default link LspCxxHlSymClass cxxTypeAlias

" ==== neoclide/coc.nvim ====

" coc extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-vimlsp',
      \ 'coc-cmake',
      \ 'coc-highlight',
      \ 'coc-pyright'
      \ ]

set signcolumn=number
" <TAB> to select candidate forward or
" pump completion candidate
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<TAB>"
" <s-TAB> to select candidate backward
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<s-TAB>"
" <SPACE> to comfirm selected candidate coc#pum#confirm
inoremap <silent><expr> , coc#pum#visible() ? coc#pum#insert() : ","
" <ESC> to cancel selected
inoremap <silent><expr> <ESC> coc#pum#visible() ? coc#pum#cancel() : "\<ESC>"

" only when there's selected complete item

if exists('*complete_info')
  inoremap <silent><expr> <CR> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if(index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
command! -nargs=0 Format :call CocAction('format')

" diagnostic info
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<CR>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <LEADER>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:generate_compile_commands()
  if empty(glob('CMakeLists.txt'))
    echo "Can't find CMakeLists.txt"
    return
  endif
  if empty(glob('.vscode'))
    execute 'silent !mkdir .vscode'
  endif
  execute '!cmake -DCMAKE_BUILD_TYPE=debug
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -S . -B .vscode'
endfunction
command! -nargs=0 Gcmake :call s:generate_compile_commands()

" ==== puremourning/vimspector ====
let g:vimspector_enable_mappings = 'HUMAN'

function! s:generate_vimspector_conf()
  if empty(glob( '.vimspector.json' ))
    if &filetype == 'c' || 'cpp'
      !cp ~/.vim/.vimspector_conf/c_cpp_conf.json ./.debug/.vimspector.json
    elseif &filetype == 'python'
      !cp ~/.vim/.vimspector_conf/python_conf.json ./.debug/.vimspector.json
    endif
  endif
  e .vimspector.json
endfunction

command! -nargs=0 Gvimspector :call s:generate_vimspector_conf()

nmap <Leader>v <Plug>VimspectorBalloonEval
xmap <Leader>v <Plug>vimspectorBalloonEval


"======== vim-markdown ============
let g:vim_markdown_folding_style_pythonic = 1

" ??????<C-s>????????????
inoremap <silent><C-s> <ESC>:w<CR>a
nnoremap <silent><C-s> :w<CR>

" ??????????????????
set backspace=indent,eol,start

inoremap <silent><nowait> ( ()<ESC>i
inoremap <silent><nowait> () ()
inoremap <silent><nowait> (<CR> ()<ESC>i<CR><ESC>O
inoremap <silent><nowait> { {}<ESC>i
inoremap <silent><nowait> {} {}
inoremap <silent><nowait> {<CR> {}<ESC>i<CR><ESC>O
inoremap <silent><nowait> [ []<ESC>i
inoremap <silent><nowait> [] []
inoremap <silent><nowait> [<CR> []<ESC>i<CR><ESC>O
nnoremap <silent><nowait> <TAB> :bnext<CR>
nnoremap <silent><nowait> <S-TAB> :bprevious<CR>
