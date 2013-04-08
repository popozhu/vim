""""""""""""""""""""""""""""""""""""
"   http://amix.dk/vim/vimrc.html
"""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" highlight when searching
set hls
" Key mapping to stop the search highlight
nmap <leader>f :nohlsearch<CR>
" When searching try to be smart about cases 
set smartcase
nnoremap * *``  " the cursor jump back
"noremap # #``   " the cursor jump back

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2


" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Remember info about open buffers on close
set viminfo^=%

"Always show current position
set ruler
" show line number
set nu

" Always show the status line
set laststatus=2
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ \ line:\ %l\ \ \ per:\ %P


" switch the window
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" ctrl+w s split a horizontal window
" ctrl+w v sllit a vertical window
" ctrl+w q quit current window

syntax enable
syntax on
filetype plugin indent on 
set autoindent
set smartindent
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab

" encoding
set enc=utf8 
set fencs=utf8,gbk,gb2312,gb18030,cp936


" copy something from vim to osX clipboard
" ref: http://vim.wikia.com/wiki/In_line_copy_and_paste_to_system_clipboard
" for mac
if has("mac") || has("macunix")
	vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
	"nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p
endif




"""""""""""""""""""""""""   plugin's conf here  """"""""""""""""""""
"let g:miniBufExplModSelTarget = 1 

" https://github.com/tpope/vim-pathogen/
call pathogen#infect()


" git clone git://github.com/altercation/solarized.git
set t_Co=256	" xterm-256 colors
set background=dark
let g:solarized_termcolors=256
colorscheme solarized


" Tag list (ctags)
nmap <leader>j :TlistToggle<cr>     	",j打开tlist窗口
set tags=tags;	" 设置tags的目录
set autochdir
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 
let Tlist_Auto_Open = 1				   "自动打开

" Tagbar (ctags)
"set tags=tags;	" 设置tags的目录
"nnoremap <leader>j :TagbarToggle<cr>
"let g:tagbar_ctags_bin = '/usr/bin/ctags'
"let g:tagbar_autoshowtag = 1
"let g:tagbar_sort = 0
"let g:tagbar_width = 30
"let g:tagbar_foldlevel = 2
"autocmd FileType c,cpp,h nested :TagbarOpen
"  o/za 切换光标下的折叠状态，如果光标下没有折叠，切换当前的折叠状态。
"  <C-N> 转到下一个顶层 tag。
"  <C-P> 转到前一个顶层 tag。
" g<c-]> list the tag list


" h/cpp  hot key
":A  "在新Buffer中切换到c/h文件
":AS "横向分割窗口并打开c/h文件
":AV "纵向分割窗口并打开c/h文件
":AT "新建一个标签页并打开c/h文件






"""""""""""""""""""""""   function here   """"""""""""""""""""""

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


function! QuitLastWindow()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
"autocmd WinEnter * call QuitLastWindow()


