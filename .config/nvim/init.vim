if has('mac')
  set clipboard=unnamed
else
  set clipboard=unnamedplus " allow yanks to go to system clipboard
endif
set encoding=utf-8
let $LANG = 'en'
set langmenu=none
set hidden              " put modified buffer into background
filetype on
augroup custom
  autocmd!
  autocmd BufNewFile,BufRead *.json.builder set ft=ruby
  autocmd BufNewFile,BufRead *.docx.caracal set ft=ruby
  autocmd QuickFixCmdPost [^l]* nested cwindow
augroup END
set number
set autowriteall        " automatically save buffer when switching
" set cursorline        " highlight current line
set expandtab           " always use spaces instead of tabs
set mouse=a             " Enable mouse support
let mapleader = ","
set diffopt=vertical    " split diffs vertically


" " right colors when running Vim inside tmux or in my favourite true-color enabled terminal!
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Set this in your vimrc file to disabling highlighting
let g:ale_pattern_options = {'ale_enabled': 0}
"let g:ale_set_highlights = 0
"let g:ale_completion_enabled = 1

" :Ag
let g:ag_working_path_mode="r"
nnoremap <Leader>A :call SearchWordWithAg()<CR>
vnoremap <Leader>A :call SearchVisualSelectionWithAg()<CR><Paste>

function! SearchWordWithAg()
	execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
	let old_reg = getreg('"')
	let old_regtype = getregtype('"')
	let old_clipboard = &clipboard
	set clipboard&
	normal! ""gvy
	let selection = getreg('"')
	call setreg('"', old_reg, old_regtype)
	let &clipboard = old_clipboard
	execute 'Ag' selection
endfunction

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1


" Write while closing files
set autowrite

" Highlight search results
set hlsearch

" split windows in this order
set splitright
set splitbelow

" Show matching brackets
set showmatch

" Indenting options
set autoindent
set smartindent
set tabstop=2 softtabstop=2 expandtab shiftwidth=2

" keine nervigen Nachrichten mehr wenn doppelt auf
set noswapfile

" " light blues
" hi xmlTagName guifg=#59ACE5
" hi xmlTag guifg=#59ACE5

" " dark blues
" hi xmlEndTag guifg=#2974a1

" Mappings
inoremap kj <Esc>
nnoremap <silent> <esc><esc>      :noh<cr>:ccl<cr>:TcloseAll<cr>:call CloseAllLocationListAndQuickfixWindows()<cr><C-w>=
nmap     <silent> <leader>w  :BW<cr>
nnoremap         <up>             gk
nnoremap         <down>           gj
nnoremap         k                gk
nnoremap         j                gj

function! CloseAllLocationListAndQuickfixWindows()
  let current_win = winnr()
  windo if &buftype == "quickfix" || &buftype == "locationlist" | lclose | endif
  execute current_win . 'wincmd w'
endfunction

let g:vimrubocop_config = '.rubocop.yml'
let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '


"----------------
"--> PLUGUINS <--
"---------------

" install vim-plug if needed.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
"colors
Plug 'chriskempson/vim-tomorrow-theme'

" FUGITIVE.VIM git wrapper
Plug 'tpope/vim-fugitive'

" Surroung surroundings: parentheses, brackets, quotes,
Plug 'tpope/vim-surround'

" Fuzzy Find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map <Leader>f :Files<CR>
map <Leader>b :Buffers<CR>
nnoremap <silent> <leader>a :Ag<cr>
let $FZF_DEFAULT_OPTS = '--bind alt-a:select-all --preview "
  \ [[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
  \ (bat --style=numbers --color=always {} ||
  \  cat {}) 2> /dev/null | head -30"'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

"NerdTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
map <Leader>n :NERDTreeToggle<CR>
map <Leader>N :NERDTreeFind<CR>
let NERDTreeIgnore = [
            \ '\~$',
            \ '\.pyc$',
            \ '__pycache__',
            \ 'node_modules',
            \ '.egg-info$',
            \ '^venv$',
            \ ]
let NERDTreeChDirMode = 2
call plug#end()

"Nerd Commenter
Plug 'scrooloose/nerdcommenter'

"AutoSave is per default disbled"
Plug '907th/vim-auto-save'

" Multicursor
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_exit_from_insert_mode = 0

" vimtex support for LaTex
Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'

" RuboCop
Plug 'ngmy/vim-rubocop'

" vim-jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" set filetypes as typescript.jsx

" Indentlines
Plug 'yggdroot/indentline'

" Languages
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'

" colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/desert-warm-256'

" elm
Plug 'elmcast/elm-vim'

" groovy syntax and .gradle files
Plug 'tfnico/vim-gradle'

" ale
Plug 'w0rp/ale'

" emmmet
Plug 'mattn/emmet-vim'
" let g:user_emmet_leader_key=','

Plug 'tpope/vim-dispatch'

Plug 'janko-m/vim-test'
" Test

let g:test#strategy = 'neoterm'
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoscroll = 1      " autoscroll to the bottom when entering insert mode
" let g:neoterm_size = 20
" let g:neoterm_fixedsize = 1       " fixed size. The autosizing was wonky for me
let g:neoterm_keep_term_open = 0  " when buffer closes, exit the terminal too.
" let test#ruby#rspec#options = { 'suite': '--profile 5' }
let test#ruby#rspec#executable = "bundle exec rspec"
" let test#strategy = "dispatch"
" let test#ruby#rspec#executable = "bundle exec rspec"
let g:dispatch_compilers = {}
let g:dispatch_compilers["bundle exec rspec"] = "rspec"

nmap <leader>s :TestNearest<cr>
nmap <leader>t :TestFile<cr>
nmap <leader>l :TestLast<cr>
nmap <leader>c :Tclose<cr>  " close vim terminal

Plug 'tpope/vim-eunuch'   " :Rename, :Move, :Chmod etc.

Plug 'tpope/vim-rails'
let g:rails_projections = {
\  "app/*.rb": {
\    "test": "spec/{}_spec.rb"
\ },
\}

Plug 'qpkorr/vim-bufkill'

Plug 'christoomey/vim-tmux-navigator'

Plug 'kassio/neoterm'

Plug 'airblade/vim-gitgutter'

Plug 'ntpeters/vim-better-whitespace'
autocmd FileType <javascript,c,java,html,erb,ruby,json,css,vim> EnableStripWhitespaceOnSave
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" split gS, join gJ
Plug 'andrewradev/splitjoin.vim'

Plug 'vim-ruby/vim-ruby'

Plug 'tpope/vim-endwise'

" text objects: ar/ir blocks, am/im methods
Plug 'rhysd/vim-textobj-ruby'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-repeat'
call plug#end()

syntax enable
set background=dark
" let g:solarized_termcolors=256
" let g:solarized_visisbility = "high"
" let g:solarized_contrast = "high"
" let g:solarized_termtrans = 1
colorscheme molokai

