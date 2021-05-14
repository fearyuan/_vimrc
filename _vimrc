" Plugins will be downloaded under the specified directory.
call plug#begin('$VIM\vim82\plugged')

" Declare the list of plugins.
Plug 'Lucas-Wye/Automatic-for-Verilog-RTLTree'

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


"��������
"-----------------------------------------------------------------
let &termencoding=&encoding
set fileencodings=utf-8,gbk,gb18030,gb2312,cp936,ucs-bom,latin1

"��������
"-----------------------------------------------------------------
set showmatch                   	 "������ʾƥ�������
set matchtime    =2             	 "�������ŵ���˸ʱ��
set shiftwidth   =4             	 "�Զ�������
set tabstop      =4             	 "tab�Ʊ��
set softtabstop  =4             	 "4���ո����Ϊtab��
set expandtab                   	 "tab����Ϊ�ո��  
set smarttab                    	 "ʹ���˸��ʱ���tab
set number                      	 "�к���ʾ
"set cursorline                 	 "ͻ����ʾ��ǰ��
set lbr                         	 "������ʾʱ���۶ϵ���
colo desert                          "ɳĮ����
set guifont=Consolas-with-Yahei:h14  "consolas�ź������14�ֺ�
"set guifont=Courier_New:h16    	 "Courier_New�����16�ֺ�
"set guifont=������:h16:cGB2312 	 "�����壬16�ֺţ�gb2312���뷽ʽ
set nobackup                    	 "�����ɱ����ļ�~
set noswapfile                  	 "�����ɽ����ļ�.swp
"set lines=30 columns=100       	 "����ʱ���ڴ�С����
au GUIEnter * simalt ~x         	 "����ʱ�������
"set nowrap                     	 "������
"set guioptions+=b              	 "���ˮƽ������
"set guioptions-=m                   " ���ز˵���
set guioptions-=T                    " ���ع�����
"set guioptions-=L                   " ������������
"set guioptions-=r                   " �����Ҳ������
"set guioptions-=b                   " ���صײ�������
"set showtabline=0                   " ����Tab��
filetype indent on              	 "�������������ʽʵ���Զ�����
set foldmethod=marker                "�۵����ñ�Ƿ�

"match�������
"-----------------------------------------------------------------
let b:match_words = '\<function\>:\<endfunction\>,'
					\ . '\<task\>:\<endtask\>,'
					\ . '\<module\>:\<endmodule\>,'
					\ . '\<begin\>:\<end\>,'
					\ . '\<case\>:\<endcase\>,'
					\ . '\<class\>:\<endclass\>,'
					\ . '\<for\>:\<endfor\>,'
					\ . '\<while\>:\<endwhile\>,'
					\ . '\<specify\>:\<endspecify\>,'
					\ . '\<generate\>:\<endgenerate\>,'
					\ . '\<\(ifdef\|ifndef\)\>:\<\(else\|elsif\)\>:\<endif\>,'
					\ . '`\<\(ifdef\|ifndef\)\>:`\<\(else\|elsif\)\>:`\<endif\>'

"������λ��
"-----------------------------------------------------------------
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"��ݼ�����
"-----------------------------------------------------------------
let t:RtlTreeVlogDefine = 1
map <F7> :NERDTree<CR>
"map <F8> :RtlTree<CR>
"let mapleader = ","
"nmap <leader>c "+y
"nmap <leader>v "+p

"Verilogģ��
"-----------------------------------------------------------------
:ab Zuhe always @(*)begin<Enter>if()begin<Enter>end<Enter>else begin<Enter>end<Enter>end
:ab Shixv always @(posedge clk)begin<Enter>if(rst)begin<Enter>end<Enter>else if()begin<Enter>end<Enter>end
:ab Jsq always @(posedge clk)begin<Enter>if(rst)begin<Enter>cnt <= 0;<Enter>end<Enter>else if(add_cnt)begin<Enter>if(end_cnt)begin<Enter>cnt <= 0;<Enter>end<Enter>else begin<Enter>cnt <= cnt + 1;<Enter>end<Enter>end<Enter>end<Enter>assign add_cnt = ;<Enter>assign end_cnt = add_cnt && ;
:ab Ztj always @(posedge clk)begin<Enter>if(rst)begin<Enter>state_c <= IDLE;<Enter>end<Enter>else begin<Enter>state_c <= state_n;<Enter>end<Enter>end<Enter>always @(*)begin<Enter>case(state_c)<Enter>IDLE:begin<Enter>if(idle2s1)begin<Enter>state_n <= S1;<Enter>end<Enter>else begin<Enter>state_n <= state_c;<Enter>end<Enter>end<Enter>S1:begin<Enter>if(s12s2)begin<Enter>state_n <= S2;<Enter>end<Enter>else begin<Enter>state_n <= state_c;<Enter>end<Enter>end<Enter>S2:begin<Enter>if(s22idle)begin<Enter>state_n <= IDLE;<Enter>end<Enter>else begin<Enter>state_n <= state_c;<Enter>end<Enter>end<Enter>default:begin<Enter>state_n <= IDLE;<Enter>end<Enter>endcase<Enter>end<Enter>assign idle2s1 = (state_c == IDLE) && ;<Enter>assign s12s2 = (state_c == S1) && ;<Enter>assign s22idle = (state_c == S2) && ;
:ab Tb reg clk, rst_n;<Enter><Enter><Enter>/*ʱ��*/<Enter>initial clk = 0;<Enter>always #5 clk = ~clk;//100MHz<Enter><Enter><Enter>/*��λ*/<Enter>initial begin<Enter>rst_n = 1;<Enter>#100 rst_n = 0;<Enter>#100 rst_n = 1;//200ns<Enter>end<Enter><Enter><Enter>/*�˿�*/<Enter>/*����*/<Enter>endmodule
