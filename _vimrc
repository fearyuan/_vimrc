" Plugins will be downloaded under the specified directory.
call plug#begin('$VIM\vim90\plugged')

" Declare the list of plugins.
Plug 'fearyuan/automatic-for-verilog'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()" Vim with all enhancements


source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


"乱码设置
"-----------------------------------------------------------------
let &termencoding=&encoding
set fileencodings=utf-8,gbk,gb18030,gb2312,cp936,ucs-bom,latin1

"常用设置
"-----------------------------------------------------------------
set showmatch                   	 "高亮显示匹配的括号
set matchtime    =2             	 "高亮括号的闪烁时间
set shiftwidth   =4             	 "自动缩进符
set tabstop      =4             	 "tab制表符
set softtabstop  =4             	 "4个空格符视为tab符
set expandtab                   	 "tab符视为空格符  
set smarttab                    	 "使用退格键时辨别tab
set number                      	 "行号显示
"set cursorline                 	 "突出显示当前行
set lbr                         	 "折行显示时不折断单词
colo desert                          "沙漠主题
set guifont=Consolas-with-Yahei:h14  "consolas雅黑字体和14字号
"set guifont=Courier_New:h16    	 "Courier_New字体和16字号
"set guifont=新宋体:h16:cGB2312 	 "新宋体，16字号，gb2312编码方式
set nobackup                    	 "不生成备份文件~
set noswapfile                  	 "不生成交换文件.swp
"set lines=30 columns=100       	 "启动时窗口大小设置
au GUIEnter * simalt ~x         	 "启动时窗口最大化
"set nowrap                     	 "不折行
"set guioptions+=b              	 "添加水平滚动条
"set guioptions-=m                   " 隐藏菜单栏
set guioptions-=T                    " 隐藏工具栏
"set guioptions-=L                   " 隐藏左侧滚动条
"set guioptions-=r                   " 隐藏右侧滚动条
"set guioptions-=b                   " 隐藏底部滚动条
"set showtabline=0                   " 隐藏Tab栏
filetype indent on              	 "载入相关缩进格式实现自动缩进
set foldmethod=marker                "折叠采用标记法

"match插件配置
"-----------------------------------------------------------------
runtime macros/matchit.vim

"nerdtree插件配置
"-----------------------------------------------------------------
nnoremap <silent> <expr> <F7> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
"map <F7> :NERDTree<CR>

"easy align插件配置
"-----------------------------------------------------------------
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"vim airline插件配置
"-----------------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

"保存光标位置
"-----------------------------------------------------------------
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"其他快捷键设置
"-----------------------------------------------------------------
"let t:RtlTreeVlogDefine = 1
"map <F8> :RtlTree<CR>
"let mapleader = ","
"nmap <leader>c "+y
"nmap <leader>v "+p

"Verilog模板
"-----------------------------------------------------------------
:ab Zuhe always @(*)begin<Enter>if()begin<Enter>end<Enter>else begin<Enter>end<Enter>end
:ab Shixv always @(posedge clk)begin<Enter>if(rst)begin<Enter>end<Enter>else if()begin<Enter>end<Enter>end
:ab Jsq always @(posedge clk)begin<Enter>if(rst)begin<Enter>cnt <= 0;<Enter>end<Enter>else if(add_cnt)begin<Enter>if(end_cnt)begin<Enter>cnt <= 0;<Enter>end<Enter>else begin<Enter>cnt <= cnt + 1;<Enter>end<Enter>end<Enter>end<Enter>assign add_cnt = ;<Enter>assign end_cnt = add_cnt && ;
:ab Ztj always @(posedge clk)begin<Enter>if(rst)begin<Enter>state_c <= IDLE;<Enter>end<Enter>else begin<Enter>state_c <= state_n;<Enter>end<Enter>end<Enter>always @(*)begin<Enter>case(state_c)<Enter>IDLE:begin<Enter>if(idle2s1)begin<Enter>state_n = S1;<Enter>end<Enter>else begin<Enter>state_n = state_c;<Enter>end<Enter>end<Enter>S1:begin<Enter>if(s12s2)begin<Enter>state_n = S2;<Enter>end<Enter>else begin<Enter>state_n = state_c;<Enter>end<Enter>end<Enter>S2:begin<Enter>if(s22idle)begin<Enter>state_n = IDLE;<Enter>end<Enter>else begin<Enter>state_n = state_c;<Enter>end<Enter>end<Enter>default:begin<Enter>state_n = IDLE;<Enter>end<Enter>endcase<Enter>end<Enter>assign idle2s1 = (state_c == IDLE) && ;<Enter>assign s12s2 = (state_c == S1) && ;<Enter>assign s22idle = (state_c == S2) && ;
:ab Tb reg clk, rst_n;<Enter><Enter><Enter>/*Clock define*/<Enter>initial clk = 0;<Enter>always #5 clk = ~clk;//100MHz<Enter><Enter><Enter>/*Reset define*/<Enter>initial begin<Enter>rst_n = 1;<Enter>#100 rst_n = 0;<Enter>#100 rst_n = 1;//200ns<Enter>end<Enter><Enter><Enter>/*Drive define*/<Enter>/*Instantiation define*/<Enter>endmodule
