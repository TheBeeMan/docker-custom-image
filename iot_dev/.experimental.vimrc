" Set global leaer key
let mapleader = ","

" Set runtime path
set rtp+=~/.vim/bundle/Vundle.vim

" Show current function name in status bar
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map <leader><leader> :call ShowFuncName() <CR>

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

	" Command-T is a Vim plug-in that provides an extremely fast "fuzzy" mechanism for:
	Plugin 'wincent/command-t'

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

	" Lean & mean status/tabline for vim that's light as air.
	Plugin 'vim-airline/vim-airline'

    " This vim plugin allows toggling bookmarks per line
    Plugin 'MattesGroeger/vim-bookmarks'

	" This repository contains snippets files for various programming languages.
	Plugin 'honza/vim-snippets'

	" cscope-maps for fuzzy symbol finder
	Plugin 'dr-kino/cscope-maps'

	Plugin 'indentLine.vim'

	" Load autocompletion plugin
	Plugin 'Valloric/YouCompleteMe'
	" This plug-in provides automatic closing of quotes, parenthesis, brackets, etc
	Plugin 'delimitMate.vim'

	" ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and 
	" semantic errors) in NeoVim 0.2.0+ and Vim 8 while you edit your text files, 
	" and acts as a Vim Language Server Protocol client
    Plugin 'dense-analysis/ale'
call vundle#end()   

" =======================================
" Nerdtree plugin configuration
nmap <F2> :NERDTreeToggle<CR>
nmap <Leader>q :NERDTreeFind %<CR>

" =======================================
	" Plugin 'dr-kino/cscope-maps'
	" update cscope database and reinit from vim"
	map <F5> :!cscope -Rb<CR>:cs reset<CR><CR>

" =======================================
" Plugin 'SirVer/ultisnips' configuration
	" Trigger configuration. Do not use <tab> if you use 
	" https://github.com/Valloric/YouCompleteMe.
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-b>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"
	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit="vertical"

" =======================================
" Plugin 'Valloric/YouCompleteMe' configuration
	set runtimepath+=~/.vim/bundle/YouCompleteMe
	autocmd InsertLeave * if pumvisible() == 0|pclose|endif		" 离开插入模式后自动关闭预览窗口
	let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM基于标签引擎
	let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
	let g:syntastic_ignore_files=[".*\.py$"]
	let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
	let g:ycm_complete_in_comments = 1
	let g:ycm_confirm_extra_conf = 0                            " 关闭加载.ycm_extra_conf.py提示
	let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键,没有这个会拦截掉tab, 导致其他插件的tab不能用.
	" let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
	let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
	let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
	let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
	let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
	let g:ycm_show_diagnostics_ui = 0                           " 禁用语法检查
	inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"             " 回车即选中当前项
	nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>     " 跳转到定义处
	let g:ycm_min_num_of_chars_for_completion=2                 " 从第2个键入字符就开始罗列匹配项

" =======================================
" Plugin 'vim-airline/vim-airline'
	"let g:airline#extensions#tabline#enabled = 1
	" Display color
	set t_Co=256
	set laststatus=2
	" Using powerline font
	let g:airline_powerline_fonts = 1
	" Enable tabline
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = ' '
	" Displaying buffer number in tabline
	let g:airline#extensions#tabline#buffer_nr_show = 1
	" Mapping hotkey to switch across buffer 
	nnoremap [b :bp<CR>
	nnoremap ]b :bn<CR>
	map <leader>1 :b 1<CR>
	map <leader>2 :b 2<CR>
	map <leader>3 :b 3<CR>
	map <leader>4 :b 4<CR>
	map <leader>5 :b 5<CR>
	map <leader>6 :b 6<CR>
	map <leader>7 :b 7<CR>
	map <leader>8 :b 8<CR>
	map <leader>9 :b 9<CR>

" =======================================
" Plugin 'taglist.vim' configuration
	map <F3> :TlistToggle<CR>
	let Tlist_Use_Right_Window=1
	let Tlist_Show_One_File=1
	let Tlist_Exit_OnlyWindow=1
	let Tlist_WinWidt=25

" =======================================
" Plugin 'preservim/nerdtree' configuration
	map <F2> :NERDTreeToggle<CR>
	let NERDTreeWinSize=25

" =======================================
" FZF plugin configuration
	nmap <C-p> :FZF<CR>

" =======================================
" Plugin 'Command-T' configuration
	nnoremap <leader>f :CommandT<CR>
	let g:CommandTTraverseSCM = 'pwd'
	set wildignore+=*.o,*.obj,.git,*.pyc,*.so,blaze*,READONLY,llvm,Library*
	set wildignore+=CMakeFiles,packages/*,**/packages/*,**/node_modules/*
	" This appears to be necessary; command-t doesn't appear to be falling back to
	" wildignore on its own.
	let g:CommandTWildIgnore=&wildignore


" =======================================
" Plugin 'dense-analysis/ale' configuration
	let g:ale_sign_column_always = 1
	let g:ale_set_highlights = 0
	let g:ale_sign_error = '✗'
	let g:ale_sign_warning = '⚡'
	let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
	let g:ale_echo_msg_error_str = 'E'
	let g:ale_echo_msg_warning_str = 'W'
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_lint_on_enter = 0
	let g:ale_linters = {
	\   'c++': ['gcc'],
	\   'c': ['gcc'],
	\   'python': ['pylint'],
	\}
	let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en'
	nmap sp <Plug>(ale_previous_wrap)
	nmap sn <Plug>(ale_next_wrap)
	nmap <Leader>s :ALEToggle<CR>
	nmap <Leader>d :ALEDetail<CR>

" =======================================
" Automaticly complete some stuff when you create a new file
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
" SetTitle for inserting some stuffes in the begginning
func SetTitle()
    if &filetype == 'sh'
        call setline(1, "##########################################################################")
        call append(line("."), "# File Name: ".expand("%"))
        call append(line(".")+1, "# Author: soh0ro0t")
        call append(line(".")+2, "# mail: thebeemangg@gmail.com")
        call append(line(".")+3, "# Created Time: ".strftime("%c"))
        call append(line(".")+4, "#########################################################################")
        call append(line(".")+8, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: soh0ro0t")
        call append(line(".")+2, "    > Mail: thebeemangg@gmail.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "")
        call append(line(".")+8, "void")
        call append(line(".")+9, "main(int argc, char *argv[]) {")
        call append(line(".")+10, "")
        call append(line(".")+11, "}")
    endif
    "    if &filetype == 'java'
    "        call append(line(".")+6,"public class ".expand("%"))
    "        call append(line(".")+7,"")
    "    endif
    autocmd BufNewFile * normal G
endfunc

au BufRead,BufNewFile *  setfiletype txt	" Hilight normal text file
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

" ===============================================================
" Global vim settings with built-in features
" Mapping copy selected data to system clipboard to <C-c> 
vmap <C-c> :w !xclip -sel c <CR><CR>
" Use "very magic" mode for searching 
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v

nmap <leader>w :w!<cr>

" Mapping ctrl-a and ctrl-c 
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
vmap <C-c> "+y

" Reload file content when it's changed
set autoread
" quickfix mode
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

set paste
set completeopt=preview,menu	" Completing code 
filetype plugin on
set clipboard=unnamed			" Shares clipboard
set nobackup					" Never back up
:set makeprg=g++\ -Wall\ \ %	" Running make command
set autowrite					" Save automaticly 
set ruler						" Open state line runler
set cursorline					" Hilight current line
set magic						" Sets magic
set guioptions-=T				" Hides toolbar
set guioptions-=m				" Hides menu bar
set foldcolumn=0
" set foldmethod=indent
set foldlevel=3
" set foldenable				" Set fold automaticly
set nocompatible				" Do not use vi's keyboard mode
set syntax=o1n					" Hilight syntax
set noeb
set confirm						" Prompt a confirm dialog when saves a file
set autoindent
set cindent
set tabstop=4					" Sets width of tab key
set softtabstop=4				" A tab = 4 spaces key
set shiftwidth=4
set noexpandtab					" Do not use space sequences instead TAB
set smarttab					" Using tab at the beginning of a line and block
set number
set history=1000				" Sets maximum history number 
set nobackup
set ignorecase					" Ignores cases when seaching
set hlsearch					" Hilight seaching content
set incsearch
set gdefault					" Displace within current line
set enc=utf-8					" Sets encoding
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8		" Sets language 
set helplang=cn
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2				" Sets current line
set cmdheight=2					" Sets current line hight
filetype indent on				" Set automatic indent for specific file 
set viminfo+=!					
set iskeyword+=_,$,@,%,#,-		" Do not split words contains the specific characters
set linespace=0
set wildmenu
set backspace=2					" Using BS key to handle indent, eol, start
set whichwrap+=<,>,h,l			
set mouse=a						" Using mouse in buffer
set selection=exclusive
set selectmode=mouse,key
set report=0					" Tell which line is changed 
set fillchars=vert:\ ,stl:\ ,stlnc:\	
set showmatch					" Hilight content within a pair of brackets
set matchtime=1					" Specify the period that matches brackets 
set scrolloff=3					
set smartindent					" Indent automaticly for c language

