" a.vim
nmap <c-y> :A <cr>

" quckfix
nmap cn :cn<cr>
nmap cp :cp<cr>
nmap cw :cw<cr>
nmap cc :ccl<cr>
nmap ccl :ccl<cr>

" dir
nmap <c-e> :Ex <cr>

" high light cur line
set cursorline
hi CursorLine  cterm=NONE   ctermbg=darkred ctermfg=white
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white

"=============================================================================
" common setup
"=============================================================================
set nocp
set nu
set paste
set foldmethod=marker
set nobackup
set noswapfile
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2
" 光标总在中间
set scrolloff=3

" Tab related
set ts=4
set sw=4
set smarttab
set ambiwidth=double

" Format related
set tw=78
set lbr
set fo+=mB

" Indent related
set cin
set ai
set cino=:0g0t0(2su2s
set autoindent

" Editing related
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive

" Misc
set wildmenu
"set spell

" Encoding related
set encoding=utf-8
let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,cp936,gb,big5,euc-jp,euc-kr,latin1

"english enviroment setup contain menu and state
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" File type related
filetype plugin indent on
set completeopt=longest,menu,preview 

" Display related
set ru
set sm
set hls
syntax on
"colo desert
"hight current line
set cursorline
"hight current column
"set cursorcolumn

"Toggle Menu and Toolbar
if (has("gui_running"))
        set guioptions-=m
        set guioptions-=T
        map <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
endif

" ============================================================================
" Plugins settings
" ============================================================================
" Ctags
set tags=./tags,./../tags,./**/tags
"set tags+=/usr/include/qt4/tags

map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . <CR>

" TList
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=1
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
let Tlist_Enable_Fold_Column = 0
map tl :Tlist<CR>

" WinManager
let g:winManagerWindowLayout = "FileExplorer"
let g:persistentBehaviour = 1
map wm :WMToggle<CR>

" AuthorInfo
let g:vimrc_author='Donghui.Liu'
let g:vimrc_email='Donghui.Liu@163.com'
nmap <F4> :AuthorInfoDetect<cr>
map ai :AuthorInfoDetect<CR>

" A
let g:alternateNoDefaultAlternate=1

" MiniBuffer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1       " for taglist
let g:miniBufExplUseSingleClick = 1
"jump to the next file
map bn :bn<CR>
"jump to the previous file
map bp :bp<CR>

" Cscope
"set cscopequickfix=s+,c-,d-,i-,t-,e-

" Grep
nnoremap <silent> <F3> :Grep<CR>

"=============================================================================
" Platform dependent settings
"=============================================================================

if (has("win32"))

    "-------------------------------------------------------------------------
    " Win32
    "-------------------------------------------------------------------------

        "maximize window
        au GUIEnter * simalt ~x
    if (has("gui_running"))
        set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
        set guifontwide=NSimSun:h9:cGB2312
    endif

else

    if (has("gui_running"))
        set guifont=DejaVu\ Sans\ Mono\ 10
    endif
        "maximize window
        au GUIEnter * call MaximizeWindow()

endif

function! MaximizeWindow()
        silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

" C的编译和运行
"map <F5> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"       exec "w"
"       exec "!gcc % -o %<"
"       exec "! ./%<"
"endfunc

" scons的编译和运行
map <F5> :call CompileRunScons()<CR>
func! CompileRunScons()
        exec "w"
        exec "!scons . -u -j20"
endfunc

" C++的编译和运行
map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
        exec "w"
        exec "!g++ % -o %<"
        exec "! ./%<"
endfunc
