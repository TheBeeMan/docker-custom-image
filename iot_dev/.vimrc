set nocompatible                        " be iMproved, required
set tabstop=4                           " how many space keys are equivalent of a tab
set hlsearch                            " highlight the search content
set nu                                  " enable line number display
set paste                               " set paste mode
filetype on                             " required

" Setting leader key `,`
let mapleader=','
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " fzf is a general-purpose command-line fuzzy finder.
    Plugin 'junegunn/fzf'

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    Plugin 'tpope/vim-fugitive'

    " TODO: plugin from http://vim-scripts.org/vim/scripts.html
    " Plugin 'L9'
    " Git plugin not hosted on GitHub
    " Plugin 'git://git.wincent.com/command-t.git'

    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    " Install L9 and avoid a Naming conflict if you've already installed a
    " different version somewhere else.
    " Plugin 'ascenator/L9', {'name': 'newL9'}

    " NERDTree is a file system explorer for the Vim editor
    Plugin 'preservim/nerdtree'

    " ctrlp is a file fuzzy finder
    " Plugin 'kien/ctrlp.vim'

    " The plugin is a source code browser plugin for Vim and
    " provides an overview of the structure of source code files and allows
    " you to efficiently browse through source code files for different
    " programming languages.
    Plugin 'taglist.vim'

    " This vim plugin allows toggling bookmarks per line
    Plugin 'MattesGroeger/vim-bookmarks'

    Plugin 'dense-analysis/ale'
    
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" taglist plugin configures F3 hotkey
map <F3> :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidt=25

" =======================================
" To change the default keys of vim-bookmark
nmap <Leader><Leader> <Plug>BookmarkToggle
nmap <S-i> <Plug>BookmarkAnnotate
nmap <S-l> <Plug>BookmarkShowAll
" nmap <S-n> <Plug>BookmarkNext
" nmap <S-p> <Plug>BookmarkPrev
nmap <S-c> <Plug>BookmarkClear
nmap <S-x> <Plug>BookmarkClearAll
" these will also work with a [count] prefix
nmap <S>k <Plug>BookmarkMoveUp
nmap <S>j <Plug>BookmarkMoveDown
" nmap <S>g <Plug>BookmarkMoveToLine

" Nerdtree plugin configuration
nmap <F2> :NERDTreeToggle<CR>

" =======================================
" FZF plugin configuration
nmap <C-p> :FZF<CR>

if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" =======================================
" cscope plugin configuration
" Using F5 within vim to do the refresh
map <F5> :!cscope -Rb<CR>:cs reset<CR><CR>


" =======================================
" zle plugin configuration
nmap <F3> :ALEToggle<CR>
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
" Always enable sign column
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
" Custom your error and warning icon
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
" Show ale within wim
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
" Show warning or error message
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Do not review when file content modified
let g:ale_lint_on_text_changed = 'never'
" Do not review when file opened
let g:ale_lint_on_enter = 0
" It's very helpful to use clang and gcc to perform santax check of c lauguage,
" and as well as python santax check by pylint
let g:ale_linters = {
\   'c++': ['gcc'],
\   'c': ['gcc'],
\   'python': ['pylint'],
\}
let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en'
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
