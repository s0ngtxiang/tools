" hack font install in mac for [[vim-devicons]] plugin
if has('mac') && empty(glob('~/Library/Fonts/Hack\ Regular\ Nerd\ Font\ Complete\ Mono.ttf'))
    silent execute '!brew tap homebrew/cask-fonts'
    silent execute '!brew install --cask font-hack-nerd-font'
endif
" universal-ctags install in mac for [[tagbar]] plugin
if has('mac') && empty(glob('/usr/local/Cellar/universal-ctags'))
    silent execute '!brew install --HEAD universal-ctags/universal-ctags/universal-ctags'
endif
" --------------------
"  vim-plug install
" --------------------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" --------------------
"  plugin install
" --------------------
call plug#begin('~/.vim/plugged')

" 文件类型插件
" ---------------------------
"   filetype:   javascript
Plug 'pangloss/vim-javascript'
"   filetype:   rust
Plug 'rust-lang/rust.vim'
"  filetype: markdown
#Plug 'godlygeek/tabular'
#Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
"Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }



" 主题
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
" linestatus
Plug 'itchyny/lightline.vim'
" 注释
Plug 'preservim/nerdcommenter'
" git
Plug 'tpope/vim-fugitive'
" 语法
Plug 'vim-syntastic/syntastic'
" 增强移动
Plug 'easymotion/vim-easymotion'
" tag面板
Plug 'preservim/tagbar'
" 文件查找 ctrlp
Plug 'ctrlpvim/ctrlp.vim'
" 文件导航
Plug 'preservim/nerdtree' |
        \ Plug 'Xuyuanp/nerdtree-git-plugin' | 
	    \ Plug 'ryanoasis/vim-devicons'

call plug#end()




set nocompatible
" --------------------
"  Syntax and indent
" --------------------
colorscheme nord    " 主题设置
" colorscheme gruvbox
set background=dark
set guifont=Hack\ Nerd\ Font\ Mono:h18
syntax on    " 打开语法高亮
set showmatch    " 展示匹配的括号

" 高亮（当前窗口的）当前行
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

filetype plugin indent on " 打开默认文件类型优化
set autoindent


" --------------------
"  Basic editing config
" --------------------
let mapleader = ","

set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
set autochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)

" -------------------- 
"  keyboard bind
" --------------------
"  打开终端
nnoremap ;t :term<CR>
noremap ;n :lnext<CR>
noremap ;p :lprevious<CR>


" 根据文件类型缩进
au filetype javascript setl shiftwidth=2 softtabstop=2 expandtab 
" --------------------
"  Misc configurations
" --------------------

" unbind keys
nmap Q <Nop>

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright


" --------------------
" Plugin configuration
" --------------------

" NERDTree
" ----------
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
			\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror


" Syntastic
" -----------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']




" Tagbar
" -----------
nnoremap  <Leader>t :TagbarToggle<CR>
" autocmd BufEnter * nested :call tagbar#autoopen(0)


" ctrlp
nnoremap <Leader>pp :CtrlPMixed<CR>
nnoremap <Leader>pf :CtrlP<CR>
nnoremap <Leader>pb :CtrlPBuffer<CR>
nnoremap <Leader>pm :CtrlPMRU<CR>



" = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
" filetype plugin config 文件类型插件
" = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

" rust.vim
" -----------

nnoremap ;rr :RustRun<CR>
nnoremap ;rf :RustFmt<CR>
nnoremap ;rt :RustTest<CR>
nnoremap ;ra :RustTest!<CR>
let g:rust_bang_comment_leader = 1
let g:rustfmt_autosave = 1


" vim-javascript
" --------------------

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
" let g:javascript_plugin_flow = 1
