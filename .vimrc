if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"自定义
color desert
set t_Co=256
set background=dark     "背景色
set nu
set nocompatible        "非兼容模式
set ruler               "在左下角显示当前文件所在行
set report=0            "显示修改次数
set nobackup            "无备份
set fileencodings=ucs-bom,UTF-8,GBK,BIG5,latin1
set fileencoding=UTF-8
set fileformat=unix     "换行使用unix方式
set wrap
set linebreak
set ambiwidth=double
set noerrorbells        "不显示响铃
set visualbell          "可视化铃声
"set foldmarker={,}      "缩进符号
"set foldmethod=indent   "缩进作为折叠标识
"set foldlevel=100       "不自动折叠
"set foldopen-=search    "搜索时不打开折叠
"set foldopen-=undo      "撤销时不打开折叠
set updatecount=0       "不使用交换文件
set magic               "使用正则时，除了$ . * ^以外的元字符都要加反斜线

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: sxyuanh") 
        call append(line(".")+2, "\# mail: sxyuanh@163.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: sxyuanh") 
        call append(line(".")+2, "    > Mail: sxyuanh@163.com ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
 "   if &filetype == 'cpp'
 "       call append(line(".")+6, "#include<iostream>")
 "       call append(line(".")+7, "using namespace std;")
 "       call append(line(".")+8, "")
 "   endif
 "   if &filetype == 'c'
 "       call append(line(".")+6, "#include<stdio.h>")
 "       call append(line(".")+7, "")
 "   endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>


" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"新建标签  
map <M-F2> :tabnew<CR>  
"列出当前目录文件  
map <F3> :tabnew .<CR>  
"打开树状文件目录  
map <C-F3> \be  
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc



"缩进定义
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set backspace=2     "退格键可以删除任何东西

" 当前行高亮
set cursorline
highlight CursorLine cterm=none    ctermfg=none     ctermbg=235
highlight LineNr     cterm=none    ctermfg=gray     ctermbg=none

" 搜索结果高亮
set hlsearch
highlight Search     cterm=none    ctermfg=black    ctermbg=blue

" vimdiff 高亮
highlight DiffAdd    cterm=reverse ctermfg=darkcyan ctermbg=black
highlight DiffDelete cterm=none    ctermfg=gray     ctermbg=239
highlight DiffChange cterm=none    ctermfg=none     ctermbg=239
highlight DiffText   cterm=bold    ctermfg=yellow   ctermbg=darkred

auto BufWritePre * sil %s/\s\+$//ge "保存时删除行尾空白

"映射常用操作
map [r :! python % <CR>
map [o :! python -i % <CR>
map <C-j> :He<CR>
map <C-l> :Ve!<CR>


