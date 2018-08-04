if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif
set nocompatible
set bs=indent,eol,start
set viminfo='20,\"50
set history=50
set ruler
if has("autocmd")
  augroup fedora
  autocmd!
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif
if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
filetype plugin on
if &term=="xterm"
     set t_Co=8
     set t_Sbet t_Sfet expandtab
endif
set tabstop=4
set softtabstop=4
set autoindent
"set smartindent
set shiftwidth=4
set incsearch
set ignorecase
set smartcase
set hlsearch
set number
set whichwrap=b,s,h,l,<,>,[,],~
set showmatch
set wildmenu
set clipboard+=unnamed
set noswapfile
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
let &guicursor = &guicursor . ",a:blinkon0"
