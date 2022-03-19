" Выключаем режим совместимости с Vi
set nocompatible

" Включаем распознавание типов файлов и типо-специфичные плагины
filetype on

""""""""""""""""""""
" Настройка Vundle "
""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" Позволить Vundle управлять собой
Bundle 'gmarik/vundle'

" Мои bundle'ы
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Tagbar'
Plugin 'vimwiki/vimwiki'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'edkolev/tmuxline.vim'
"Plugin 'itchyny/calendar.vim'
Plugin 'vim-latex/vim-latex'
" Golang
Plugin 'fatih/vim-go'

""""""""""""""""""""""
" Основные настройки "
""""""""""""""""""""""

filetype plugin on
filetype indent on

" Настройки tab'ов для Python
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set expandtab " Ставим tab'ы пробелами


" Использовать 256 цветов
"set t_Co=256

" Цветовая тема
"let g:solarized_termcolors=256
set background=light
colorscheme solarized
" colorscheme zellner

" Подсветка синтаксиса
syntax on

" Спрятать курсор мыши, когда набираем текст
set mousehide

" Не пищать
set t_vb=0

" Переносим на другую строку, разрыв строки
set wrap
set linebreak

" Выключаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set encoding=utf-8 " Кодировка файлов по умолчанию
set fileencoding=utf-8 " The encoding written to file.

" Включаем автообновление, если файл был изменен извне
set autoread

" Включить подсветку скобок
set showmatch

" Автоматически менять cwd окна на директорию открытого файла
" set autochdir

" Изменение клавиши <Leader> с '\' на ','
:let mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""
" Подсветка достижения 120 символов в строке "
""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=LightGrey guibg=Black
    autocmd FileType python match Excess /\%150v.*/
    autocmd FileType python set nowrap
augroup END

"""""""""""""""""""""""
"  Настройка AirLine  "
"""""""""""""""""""""""
set laststatus=2

""""""""""""""""""""""
" Настройка NerdTree "
""""""""""""""""""""""
let NERDTreeIgnore = ['\.pyc$']
map <F2> :NERDTreeToggle<CR>

"""""""""""""""""""""
" Настройка PyClewn "
"""""""""""""""""""""
" nmap <F3> :Pyclewn<CR>
" imap <F3> <Esc>:Pyclewn<CR>

"""""""""""""""""""
" Настройка split "
"""""""""""""""""""
nmap <F5> :vsplit<CR>
imap <F5> <Esc>:vsplit<CR>
nmap <F6> :split<CR>
imap <F6> <Esc>:split<CR>

""""""""""""""""""""
" Настройка TagBar "
""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""
" Настройка YouCompleteMe "
"""""""""""""""""""""""""""
nmap <Leader>d :YcmCompleter GoToDefinition<CR>
let g:ycm_global_ycm_extra_conf = '/home/svart/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_extra_conf_globlist = ['~/emzos/*', '~/emzior/*', '~/mprouter/*']

"""""""""""""""""""""""
" Настройка Syntastic "
"""""""""""""""""""""""
" let g:syntastic_quiet_messages = { 'regex': 'pasting formed' }
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_python_exec = '/usr/bin/python2'

let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_compiler_options = '-std=c99'
let g:syntastic_c_check_header = 1

nmap <Leader>sc :SyntasticCheck<CR>
nmap <Leader>st :SyntasticToggleMode<CR>

"""""""""""""""""""""
" Настройка Vimwiki "
"""""""""""""""""""""
let g:vimwiki_list = [{'path':'~/Work/vimwiki/'}]

"""""""""""""""""
" Настройка GUI "
"""""""""""""""""
if has('gui_running') " Глобальные настройки на GUI Vim
    set guioptions-=m " убираем меню
    set guioptions-=e " убираем вкладки GUI делаем их как в консоли
    set guioptions-=T " убираем тулбар
    set guioptions-=r " убираем полосы прокрутки справа
    set guioptions-=L " убираем полосы прокрутки слева
    set background=light " Цвет фона темный или светлый
    set guioptions-=R
    set guioptions-=l
endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" Настройка сокращения для переключения вкладок "
"""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>tn :tabnext<CR>
nmap <Leader>tp :tabprev<CR>
nmap <Leader>tN :tabnew<CR>


"""""""""""""""""""""""""""""""""""""""
" Настройка переключения между окнами "
"""""""""""""""""""""""""""""""""""""""
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Remove trailing whitespaces on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Highlight current line
set cursorline

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" buffers
"let g:airline#extensions#tabline#enabled = 1

" Настройка Calendar
let g:calendar_google_calendar = 1
