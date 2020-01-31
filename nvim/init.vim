call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim' 
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'sheerun/vim-polyglot'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'mhinz/vim-mix-format'
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'
Plug 'w0rp/ale'
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

let g:airline_theme='oceanicnext'
let g:airline_solarized_bg='deus'
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1

let g:ale_fixers = {'javascript': ['eslint']}

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

set title

syntax on

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
" Run Neomake when I save any buffer
augroup neomake
  autocmd! BufWritePost * Neomake
augroup END
" Don't tell me to use smartquotes in markdown ok?
let g:neomake_markdown_enabled_makers = []

" Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
let g:neomake_elixir_enabled_makers = ['mycredo']
function! NeomakeCredoErrorType(entry)
  if a:entry.type ==# 'F'      " Refactoring opportunities
    let l:type = 'W'
  elseif a:entry.type ==# 'D'  " Software design suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'W'  " Warnings
    let l:type = 'W'
  elseif a:entry.type ==# 'R'  " Readability suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'C'  " Convention violation
    let l:type = 'W'
  else
    let l:type = 'M'           " Everything else is a message
  endif
  let a:entry.type = l:type
endfunction

let g:neomake_elixir_mycredo_maker = {
  \ 'exe': 'mix',
  \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
  \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
  \ 'postprocess': function('NeomakeCredoErrorType')
  \ }

colorscheme OceanicNext
:highlight LineNr ctermfg=grey

" Sane tabs
" - Two spaces wide
set tabstop=2
set shiftwidth=2
set expandtab
set number " line numbering
set encoding=utf-8
" Highlight search results
set hlsearch
" Incremental search, search as you type
set incsearch
" Ignore case when searching
set ignorecase
" Ignore case when searching lowercase
set smartcase
set title
" Stop highlighting on Enter
map <CR> :noh<CR>
