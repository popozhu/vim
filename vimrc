""""""""""""""""""""""""""""""""""""
"   http://amix.dk/vim/vimrc.html
"""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

syntax enable
syntax on

set t_Co=256	" xterm-256 colors
"colorscheme desert 

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" show line number
set nu

" highlight when searching
set hls
" Key mapping to stop the search highlight
nmap <leader>f :nohlsearch<CR>
" show matching pattern
set is

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" coding complete
set completeopt+=longest
inoremap <expr> <Esc>      pumvisible()?"\<C-e>":"\<Esc>"
inoremap <expr> <CR>       pumvisible()?"\<C-y>":"\<CR>"
inoremap <expr> <Down>     pumvisible()?"\<C-n>":"\<Down>"
inoremap <expr> <Up>       pumvisible()?"\<C-p>":"\<Up>"
"inoremap <expr> <C-d>     pumvisible()?"\<PageDown>\<C-p>\<C-n>":"\<C-d>"
"inoremap <expr> <C-u>     pumvisible()?"\<PageUp>\<C-p>\<C-n>":"\<C-u>"
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ \ Line:\ %l 


" switch the window
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" ctrl+w s split a horizontal window
" ctrl+w v sllit a vertical window
" ctrl+w q quit current window
map <leader>a :res+50!<cr>
map <leader>s :res-50!<cr>

filetype plugin indent on 
set autoindent
set smartindent
noremap <leader>s :set paste<CR>	// to paste mode
noremap <leader>S :set nopaste<CR>	// leave past mode

" encoding
set enc=utf8 
set fencs=utf8,gbk,gb2312,gb18030,cp936


" copy something from vim to osX clipboard
" ref: http://vim.wikia.com/wiki/In_line_copy_and_paste_to_system_clipboard
" for mac
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p


"""""""""""""""""""""""""   plugin's conf here  """"""""""""""""""""
"let g:miniBufExplModSelTarget = 1 

" https://github.com/tpope/vim-pathogen/
call pathogen#infect()


" git clone git://github.com/altercation/solarized.git
set background=dark
let g:solarized_termcolors=256
colorscheme solarized


" Tag list (ctags)
"nmap <leader>j :TlistToggle<cr>     	",j��tlist����
"set tags=tags;	" ����tags��Ŀ¼
"set autochdir
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"let Tlist_Show_One_File = 1            "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
"let Tlist_Exit_OnlyWindow = 1          "���taglist���������һ�����ڣ����˳�vim
"let Tlist_Use_Right_Window = 1         "���Ҳര������ʾtaglist���� 
"let Tlist_Auto_Open = 1				"�Զ���

" Tagbar (ctags)
set tags=tags;	" ����tags��Ŀ¼
nnoremap <leader>j :TagbarToggle<cr>
let g:tagbar_ctags_bin = '/usr/bin/ctags'
let g:tagbar_autoshowtag = 1
let g:tagbar_sort = 0
let g:tagbar_width = 30
let g:tagbar_foldlevel = 2
autocmd FileType c,cpp,h nested :TagbarOpen
"  o/za �л�����µ��۵�״̬����������û���۵����л���ǰ���۵�״̬��
"  <C-N> ת����һ������ tag��
"  <C-P> ת��ǰһ������ tag��
" g<c-]> list the tag list


" h/cpp  hot key
":A  "����Buffer���л���c/h�ļ�
":AS "����ָ�ڲ���c/h�ļ�
":AV "����ָ�ڲ���c/h�ļ�
":AT "�½�һ����ǩҳ����c/h�ļ�


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
autocmd WinEnter * call QuitLastWindow()

