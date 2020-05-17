" Plugins
" =======
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'Rykka/riv.vim', { 'for': 'rst' }
Plug 'Rykka/InstantRst', { 'for': 'rst' }
Plug 'lervag/vimtex'
Plug 'google/vim-searchindex'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
" neoclide/coc.nvim
call plug#end()

" Colorscheme
" ===========
syntax enable
colorscheme gruvbox
set background=dark
set termguicolors
highlight Normal ctermbg=NONE guibg=NONE

" Key bindings
" ============
map Y y$
" Don't indent hashes
inoremap # X<C-H>#

" Relative line numbers
" ---------------------
nnoremap <silent> <leader>n :set number relativenumber!<CR>
" Enable relative line numbers in normal mode, disable in insert mode.
au InsertEnter * :set number norelativenumber
au InsertLeave * :set number relativenumber
set number relativenumber


" Settings
" ========
filetype on
set number
set numberwidth=1
set title
set wildmode=full
set lazyredraw
set synmaxcol=500
set complete+=kspell

" Bell/blink
" ----------
set noerrorbells
set vb t_vb=
au GuiEnter * set visualbell t_vb=

" Editing
" -------
set cursorline " have a line indicate the cursor location
set nostartofline " Avoid moving cursor to BOL when jumping around
set virtualedit=block " Let cursor move past the last char in <C-v> mode
set scrolloff=3 " Keep 3 context lines above and below the cursor
set backspace=2 " Allow backspacing over autoindent, EOL, and BOL
set showmatch " Briefly jump to a paren once it's balanced
set nowrap " don't wrap text
set linebreak " don't wrap textin the middle of a word
set smartindent " use smart indent if there is no indent file
set tabstop=4 " <tab> inserts 4 spaces
set shiftwidth=4 " but an indent level is 2 spaces wide.
set softtabstop=4 " <BS> over an autoindent deletes both spaces.
set expandtab " Use spaces, not tabs, for autoindent/tab key.
set shiftround " rounds indent to a multiple of shiftwidth
set matchpairs+=<:> " show matching <> as well
set foldmethod=indent " allow us to fold on indents
set foldlevel=99 " don't fold by default
set ttimeoutlen=50 " don't wait too long for mapped sequences on key codes
autocmd FileType rst,markdown,tex,mail setlocal spell " spell correction for some files
autocmd FileType mail setlocal formatoptions+=w " for mutt's text_flowed option

" Airline
" -------
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1 " Use special font characters

" vimtex
" ------
let g:vimtex_view_method='zathura'

" Messages/Info/Status
" --------------------
set ls=2 " always show status line
set confirm " Y-N-C prompt if closing with unsaved changes.
set showcmd " Show incomplete normal mode commands as I type.
set report=0 " : commands always print changed line count.
set shortmess+=a " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler " Show some info, even without statuslines.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})
set listchars=tab:»·,eol:↵,trail:·,precedes:«,extends:»
set list

" Searching
" ---------
set ignorecase " Default to using case insensitive searches,
set smartcase " unless uppercase letters are used in the regex.
set inccommand=nosplit

" Display
" -------
if has("gui_running")
    " Remove menu bar, toolbar and scrollbars
    set guioptions=
    " Set size
    set columns=80
    set lines=24
    au BufRead * let &numberwidth = float2nr(log10(line("$"))) + 2
              \| let &columns = &numberwidth + 80
endif
set colorcolumn=80
