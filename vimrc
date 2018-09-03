" ====================================
" Configuration for golang

set modeline

if has("multi_byte")
	set encoding=utf-8
	set termencoding=utf-8
	set formatoptions+=mM
	set fencs=utf-8,gbk
	if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
	endif
endif

"set fileencodings=utf-8,gbk,euc-cn,gb2312,big5,utf-bom,iso8859-1,iso-2022-cn,gb18030,cp936,cp950
"set encoding=utf-8
"set termencoding=gbk,utf-8
"set termencoding=utf-8,gbk

"set encoding=euc-cn
"set fileencodings=euc-cn,utf-8,gbk,gb2312,big5,utf-bom,iso8859-1,iso-2022-cn,gb18030,cp936,cp950
"set termencoding=2byte-euc-cn

set guifont=PowerlineSymbols\ for\ Powerline
set t_Co=256
"let g:Powerline_symbols='unicode'
let g:Powerline_symbols='fancy'
"let g:Powerline_stl_path_style='full'

"set updatetime=100
"set updatecount=5

nmap mmm :exe "norm " . col("$")/2 . "\|"

set tags+=$HOME/.vim/ctags/afc
set tags+=$HOME/.vim/ctags/redis
set tags+=$HOME/.vim/ctags/nginx
set tags+=$HOME/.vim/ctags/unixodbc
set tags+=$HOME/.vim/ctags/mysql
"set tags+=$HOME/.vim/ctags/linux
set tags+=$HOME/.vim/ctags/sysinc

"set relativenumber

"let g:instant_markdown_slow=0
"let g:instant_markdown_autostart=1

"hi Normal ctermbg=black ctermfg=white
if !hasmapto('<Plug>MarkSet', 'n')
	nmap <unique> <Leader>m <Plug>MarkSet
endif
if !hasmapto('<Plug>MarkSet', 'x')
	xmap <unique> <Leader>m <Plug>MarkSet
endif
if !hasmapto('<Plug>MarkRegex', 'n')
	nmap <unique> <Leader>r <Plug>MarkRegex
endif
if !hasmapto('<Plug>MarkRegex', 'x')
	xmap <unique> <Leader>r <Plug>MarkRegex
endif
if !hasmapto('<Plug>MarkClear', 'n')
	nmap <unique> <Leader>n <Plug>MarkClear
endif

:nnoremap <F5> "=strftime("%Y/%m/%d %A %H:%M:%S")<CR>gP
:inoremap <F5> <C-R>=strftime("%F>)<CR>

iab xdate <c-r>=strftime("%Y-%m-%d %H:%M:%S")<c-r>
iab xname LiuYF(fyljob@126.com)

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_WinWidth=50

colorscheme molokai

let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

"set titlestring=%{strftime(\"%Y\ %m\ %d\")}

set nocp
set showmatch

set backspace=indent,eol,start

set tw=80 fo+=Mm

set hlsearch
set ignorecase
set autoindent
set smartindent
set shiftwidth=2
"set mouse=a
set number
set ruler
set softtabstop=2
set tabstop=2
set whichwrap=b,s,<,>,[,]
set background=dark
syntax enable
syntax on
set linebreak
"set nocompatible
set wrap
set showtabline=2
set guioptions=mcr
set cursorline
hi cursorline guibg=BLACK,gui=underline
set cmdheight=1
set laststatus=2
set autochdir
"set foldmethod=indent
set tabpagemax=25
set showtabline=3

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
set laststatus=2

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction

map <F9> :call CompileRunGpp()<CR>  
func! CompileRunGpp()  
	exec "w"  
	exec "!gcc --std=c99 % -o %<"  
	exec "! ./%<"
endfunc  

map <F12> :call Debug()<CR>
func!  Debug()
	exec "w"
	exec "!gcc % -o %< -gstabs+"
	exec "! ./%<"
endfunc

nmap <BS> gcc
vmap <BS> gc

map . :w<cr>:set makeprg=gcc\ %<cr>:make<cr>
map , :!./a.out<cr>
runtime! debian.vim
if has("syntax")
	syntax on
endif

filetype plugin indent on
set completeopt=longest,menu

if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"   

" 加入注释
func SetComment()
	call append(1, '/**')
	call append(2, ' * '.expand("%s"))  
	call append(3, ' *')
	call append(4, ' * Copyright (C) '.strftime("%Y").' by Liu YunFeng.')
	call append(5, ' *')
	call append(6, ' *        Create : '.strftime("%Y-%m-%d %H:%M:%S"))
	call append(7, ' * Last Modified : '.strftime("%Y-%m-%d %H:%M:%S"))
	call append(8, ' */')
	call append(9, '')
endfunc

" 加入shell,Makefile注释  
func SetComment_sh()  
	call setline(3, "#================================================================")   
	call setline(4, "#   Copyright (C) ".strftime("%Y")." Liu YunFeng. All rights reserved.")  
	call setline(5, "#   ")   
	call setline(6, "#   文件名称：".expand("%:t"))
	call setline(7, "#   创 建 者：Liu YunFeng")
	call setline(8, "#   创建日期：".strftime("%Y年%m月%d日"))   
	call setline(9, "#   描    述：")
	call setline(10, "#")
	call setline(11, "#================================================================")  
	call setline(13, "")
endfunc

" 定义函数SetTitle，自动插入文件头
func SetTitle()
	if &filetype == 'make'
		call setline(1,"")
		call setline(2,"")
		call SetComment_sh()
	elseif &filetype == 'sh'
		call setline(1,"#!/bin/bash")
		call setline(2,"")
		call SetComment_sh()
	else
		call SetComment()
		if expand("%:e") == 'h'
			call append(10, "#ifndef __".toupper(expand("%:t:r"))."_H__")
			call append(11, "#define __".toupper(expand("%:t:r"))."_H__")
			call append(12, "")
			call append(13, "__BEGIN_DECLS")
			call append(14, "")
			call append(15, "__END_DECLS")
			call append(16, "")
			call append(17, "#endif /* __".toupper(expand("%:t:r"))."_H__ */")
		elseif &filetype == 'c'
			call append(10,"#include \"".expand("%:t:r").".h\"")
		elseif &filetype == 'cpp'
			call append(10, "#include \"".expand("%:t:r").".h\"")
		endif
	endif
endfunc

augroup filetype
	au! BufNewFile,BufRead *.log setf afclog
augroup end

command! JsonFormat :execute '%!python -m json.tool'  
				\ | :execute '%!python -c "import re,sys;chr=__builtins__.__dict__.get(\"unichr\", chr);sys.stdout.write(re.sub(r\"\\u[0-9a-f]{4}\", lambda x: chr(int(\"0x\" + x.group(0)[2:], 16)).encode(\"utf-8\"), sys.stdin.read()))"'  
				\ | :set ft=javascript  
				\ | :1  

" 启用pathogen以fmt和跳转go代码
call pathogen#infect()

" custom tab pages line
set tabline=%!MyTabLine()

function MyTabLine()
	" complete tabline goes here
	let s = ''
	" loop through each tab page
	for t in range(tabpagenr('$'))
		" set highlight
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		" set the tab page number (for mouse clicks)
		let s .= '%' . (t + 1) . 'T'
		let s .= ' '
		" set page number string
		let s .= t + 1 . ' '
		" get buffer names and statuses
		" temp string for buffer names while we loop and check buftype
		let n = ''
		" &modified counter
		let m = 0
		"counter to avoid last ' '
		let bc = len(tabpagebuflist(t + 1))
		" loop through each buffer in a tab
		for b in tabpagebuflist(t + 1)
			" buffer types: quickfix gets a [Q], help gets [H]{base fname}
			" others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
			if getbufvar( b, "&buftype" ) == 'help'
				let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
			elseif getbufvar( b, "&buftype" ) == 'quickfix'
				let n .= '[Q]'
			else
				let n .= pathshorten(bufname(b))
			endif
			" check and ++ tab's &modified count
			if getbufvar( b, "&modified" )
				let m += 1
			endif
			" no final ' ' added...formatting looks better done later
			if bc > 1
				let n .= ' '
			endif
			let bc -= 1
		endfor
		" add modified label [n+] where n pages in tab are modified
		if m > 0
			let s .= '[' . m . '+]'
		endif
		" select the highlighting for the buffer names
		" my default highlighting only underlines the active tab
		" buffer names.
		if t + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		" add buffer names
		if n == ''
			let s.= '[New]'
		else
			let s .= n
		endif
		" switch to no underlining and add final space to buffer list
		let s .= ' '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLineFill#%T'
	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLineFill#999Xclose'
	endif
	return s
endfunction
