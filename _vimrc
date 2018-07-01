"OS毎に.vimの読み込み先を変える
"以下、~/.vimを参照する場合は$VIMFILE_DIRを使う
if has('win32')
	:let $VIMFILE_DIR = $HOME . '\vimfiles'
else
	:let $VIMFILE_DIR = $HOME . '\.vim'
endif

"文字コードの内部エンコーディング
if has("gui_running") && !has("unix")
	set encoding=utf-8
endif

"保存&コンパイル&実行(実行後、実行ファイル削除)
function! F9()
	:w
	if expand("%:e") == "cpp" || expand("%:e") == "c" || expand("%:e") == "cxx"
		:!g++ %:r.%:e -o %:r.exe -O2 -Wextra -Wall -Wl,--enable-auto-import 
		:!%:r.exe && del %:r.exe
	elseif expand("%:e") == "java"
		:!javac %:r.java
		:!java %:r 
	elseif expand("%:e") == "py"
		:!python %:r.py
	endif
endfunction
map <F9> :call F9()<CR><CR>

"保存&コンパイル&実行
function! F8()
	:w
	if expand("%:e") == "cpp" || expand("%:e") == "c"
		:!g++ %:r.%:e -o %:r.exe -Wextra -Wall -Wl,--enable-auto-import 
		:!%:r.exe
	elseif expand("%:e") == "java"
		:!javac %:r.java
		:!java %:r 
	elseif expand("%:e") == "py"
		:!python %:r.py
	endif
endfunction
map <F8> :call F8()<CR><CR>

"ソースファイルのテンプレート
"augroup SkeletonAu
"	autocmd!
"	autocmd BufNewFile *.html 0r $VIMFILE_DIR/templates/skel.html
"	autocmd BufNewFile *.php 0r $VIMFILE_DIR/templates/skel.html
"	autocmd BufNewFile *.cpp 0r $VIMFILE_DIR/templates/skel.cpp
"	autocmd BufNewFile *.cxx 0r $VIMFILE_DIR/templates/skel.cpp
"augroup END

"php開発準備
function! PHP()
	:cd c:\xampp\htdocs\php
endfunction

"PHP構文チェック -----------------------------------------------------------------
"環境設定
let s:phpPath = 'C:\xampp\php\php.exe'

" 関数定義
function! s:PHPLint()
	:w
	let l:result = system(s:phpPath . ' -l ' . expand('%:p'))

	if ('No syntax errors' == strpart(result, 0, 16))
		return 0
	else
		echo l:result
		return 1
	endif
endfunction

" ブラウザアクセス -------------------------------------------------------------
" 環境設定
let s:browserPath = '"C:\Users\Mikawa\AppData\Local\Google\Chrome\Application\chrome.exe"' " Webブラウザの実行ファイル
let s:rootPath    = 'C:\xampp\htdocs\php\'       " ドキュメントルート
let s:hostPath    = 'localhost\php\'                  " ホスト

" 関数定義
function! s:PHPAccessBrowser()
	" 拡張子チェック
	let l:fileType = expand('%:e')
	if ('php' != l:fileType && 'html' != l:fileType)
		return
	endif

	" 構文チェック
	let l:lintResult = s:PHPLint()
	if (1 == l:lintResult)
		return
	endif

	" ドキュメントルート配下にないファイル、クラスファイルを除外
	let l:filePath = expand('%:p')
	if (0 == stridx(l:filePath, s:rootPath) && -1 == stridx(l:filePath, '.class.php'))
		echo system(s:browserPath . ' ' . s:hostPath . strpart(l:filePath, strlen(s:rootPath)))
	else
		echo 'No Syntax Error'
	endif
endfunction

" コマンド定義
command! CallPHPAccessBrowser call s:PHPAccessBrowser()

" <F6>キーに割り当て
augroup MyCallFunctionAutoCommand
	autocmd!
	autocmd BufNewFile,BufRead *.php,*.html :nnoremap <buffer> <F6> :<C-u>CallPHPAccessBrowser<CR>
augroup END

"ファイルをutf-8にエンコード
function! Encode_utf8()
	:set fileencoding=utf8
endfunction

"プラグインを有効にする
filetype plugin indent on

"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
"function! InsertTabWrapper()
"        let col = col('.') - 1
"        if !col || getline('.')[col - 1] !~ '\k'
"                return "\<TAB>"
"        else
"                if pumvisible()
"                        return "\<C-N>"
"                else
"                        return "\<C-N>\<C-P>"
"                end
"        endif
"endfunction
"" Remap the tab key to select action with InsertTabWrapper
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"" }}} Autocompletion using the TAB key
"
""補完オプション
"autocmd Filetype * let g:AutoComplPop_CompleteOption='.,w,b,u,t,i'

"テキスト幅を無制限にすることで強制改行を防ぐ
"set tw=0
autocmd FileType text setlocal textwidth=0

"ステータス行にファイルタイプや文字コードを表示する
function! GetStatusEx()
	let str = ''
	if &ft != ''
		let str = str . '[' . &ft . ']'
	endif
	if has('multi_byte')
		if &fenc != ''
			let str = str . '[' . &fenc . ']'
		elseif &enc != ''
			let str = str . '[' . &enc . ']'
		endif
	endif
	if &ff != ''
		let str = str . '[' . &ff . ']'
	endif
	return str
endfunction
set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}

"swapファイル
set swapfile
set directory=$VIM\backup

"backupファイル
set backup
set directory=$VIM\backup
set backupdir=C:\users\Mikawa\GoogleDrive\Application\vim\backup\

"viminfo
:set viminfo+=n$VIM/_viminfo

"構文に色を付ける
syntax on

"undofileの無効化 http://www.kaoriya.net/blog/2014/03/30/
set noundofile

"スペルチェックの有効化 (日本語は無視)
set spell
set spelllang=en,cjk

"行数の表示
set number

"インデントの幅
set shiftwidth=4

"タブの幅
set tabstop=4

"Cスタイルのインデント
set cindent

"インデント保持
set autoindent

"バックスペースの設定
set backspace=indent,eol,start

"Windowsのクリップボードと同期
set clipboard=unnamed

" 削除キーでyankしない
nnoremap x "_x
"nnoremap d "_d
nnoremap D "_D

"ESCキー連打でハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR>

"開いたファイルの存在するディレクトリに移動
au BufEnter * execute ":lcd " . expand("%:p:h")

"ステータスラインに補完候補を表示
set wildmenu

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" 自動インデント無効
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

" markdownのハイライトを有効にする
" set syntax=markdown
" au BufRead,BufNewFile *.md set filetype=markdown

" fold
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

"ruby, python, perlスクリプト実行
autocmd BufNewFile,BufRead *.rb nnoremap <C-e> :!ruby %<CR>
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python %<CR>
autocmd BufNewFile,BufRead *.pl nnoremap <C-e> :!perl %<CR>
autocmd BufNewFile,BufRead *.ipynb nnoremap <C-e> :!jupyter notebook<CR>
" autocmd BufNewFile,BufRead *.rb nnoremap <F5> :!ruby %
" autocmd BufNewFile,BufRead *.py nnoremap <F5> :!python %
" autocmd BufNewFile,BufRead *.pl nnoremap <F5> :!perl %
" autocmd BufNewFile,BufRead *.ipynb nnoremap <F5> :!jupyter notebook

" キーバインド変更
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
noremap m  %
nnoremap == gg=G''	
nnoremap <C-m><C-m> zA
nnoremap <C-m><C-l> zM
nnoremap <C-m><C-o> zR
nnoremap <C-a> gg<S-v>G
nnoremap dw diw
nnoremap ：ｗ :w<return>
inoremap <C-p> <C-r>0<CR>
inoremap <C-v> <Esc>pa
" inoremap <ESC> <ESC>:set iminsert=0<CR>  " ESCでIMEを確実にOFF

"インサートモードでも移動
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>

"括弧の補完
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap ' ''<LEFT>
inoremap < <><LEFT>
inoremap （ （）<LEFT>
"inoremap ` ``<LEFT>
"inoremap " ""<LEFT>


"=====================プラグイン関連====================="
if &compatible
  set nocompatible
endif
set runtimepath+=$VIM\dein\repos\github.com\Shougo\dein.vim

call dein#begin(expand('$VIM\dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('scrooloose/nerdtree')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('mattn/sonictemplate-vim')
call dein#add('tomtom/tcomment_vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('t9md/vim-textmanip')
call dein#add('tpope/vim-surround')
call dein#add('tomasr/molokai')
call dein#add('plasticboy/vim-markdown')

call dein#end()

filetype plugin indent on


""""""""""""""""""""""""""""""
" Template
""""""""""""""""""""""""""""""
let g:sonictemplate_vim_template_dir = ['$VIM\dein\repos\github.com\mattn\sonictemplate-vim\template', '$VIM\template']
autocmd BufNewFile,BufRead *.md nnoremap <C-t> :Template my-readme


""""""""""""""""""""""""""""""
" Unit.vim
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" ファイルは tabdrop で開く
call unite#custom#default_action('file' , 'tabopen')
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" neosnnippet
""""""""""""""""""""""""""""""
" Plugin key-mappings.  " <C-k>でsnippetの展開
imap <C-space>     <Plug>(neosnippet_expand_or_jump)
smap <C-space>     <Plug>(neosnippet_expand_or_jump)
xmap <C-space>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '$VIM\dein\repos\github.com\Shougo\neosnippet-snippets\neosnippets'

if has('conceal')
	set conceallevel=2 concealcursor=niv
endif


""""""""""""""""""""""""""""""
" vim-indent-guides
""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1


""""""""""""""""""""""""""""""
" textmanip
""""""""""""""""""""""""""""""
xmap <M-d> <Plug>(textmanip-duplicate-down)
nmap <M-d> <Plug>(textmanip-duplicate-down)
xmap <M-D> <Plug>(textmanip-duplicate-up)
nmap <M-D> <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

" toggle insert/replace with <F10>
nmap <F10> <Plug>(textmanip-toggle-mode)
xmap <F10> <Plug>(textmanip-toggle-mode)

" use allow key to force replace movement
xmap  <Up>     <Plug>(textmanip-move-up-r)
xmap  <Down>   <Plug>(textmanip-move-down-r)
xmap  <Left>   <Plug>(textmanip-move-left-r)
xmap  <Right>  <Plug>(textmanip-move-right-r)

""""""""""""""""""""""""""""""
" tcomment
""""""""""""""""""""""""""""""
" let g:tcommentMapLeaderOp1 = 'gc'

""""""""""""""""""""""""""""""
" molokai
""""""""""""""""""""""""""""""
if dein#is_sourced('molokai') " molokaiがインストールされていれば
    colorscheme molokai " カラースキームにmolokaiを設定する
endif

set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける


""""""""""""""""""""""""""""""
" vim-markdown
""""""""""""""""""""""""""""""
let g:vim_markdown_folding_level = 6
let g:vim_markdown_conceal = 0
