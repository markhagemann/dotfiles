let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +127 lua/plugins/tokyonight.lua
badd +34 lua/config/keymaps.lua
badd +99 ~/.config/nvim/lua/config/autocommands.lua
badd +1 ~/.config/nvim/lua/plugins.lua
badd +99 lua/plugins/utility.lua
argglobal
%argdel
edit lua/plugins/utility.lua
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt ~/.config/nvim/lua/plugins.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
7,8fold
5,10fold
4,11fold
2,12fold
17,18fold
14,19fold
28,29fold
22,30fold
35,49fold
32,50fold
55,56fold
52,57fold
62,67fold
59,68fold
73,76fold
78,81fold
83,86fold
72,87fold
70,88fold
94,100fold
91,101fold
106,107fold
103,108fold
118,120fold
117,121fold
125,131fold
133,134fold
124,135fold
123,136fold
113,137fold
144,151fold
143,152fold
140,153fold
159,164fold
158,165fold
167,168fold
155,169fold
176,177fold
179,184fold
186,187fold
175,188fold
195,196fold
193,197fold
191,198fold
190,199fold
203,204fold
202,205fold
201,206fold
174,207fold
218,219fold
213,220fold
211,221fold
209,222fold
224,226fold
171,227fold
236,237fold
239,241fold
235,242fold
229,243fold
249,252fold
245,254fold
256,259fold
265,266fold
261,267fold
269,271fold
276,278fold
273,279fold
292,295fold
299,300fold
297,301fold
305,307fold
303,308fold
312,317fold
320,321fold
325,326fold
310,327fold
329,332fold
338,340fold
337,342fold
334,344fold
350,351fold
346,352fold
356,357fold
360,363fold
365,368fold
359,369fold
354,370fold
374,375fold
372,376fold
381,382fold
379,383fold
399,400fold
398,403fold
395,404fold
409,411fold
406,412fold
421,424fold
419,427fold
418,428fold
415,429fold
437,438fold
434,439fold
445,446fold
444,447fold
455,458fold
454,459fold
441,460fold
462,464fold
431,465fold
474,479fold
472,481fold
483,484fold
486,487fold
489,490fold
471,491fold
470,492fold
467,493fold
501,502fold
500,503fold
496,504fold
510,511fold
508,512fold
515,517fold
519,522fold
524,529fold
538,539fold
535,540fold
532,541fold
1,542fold
let &fdl = &fdl
let s:l = 99 - ((12 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 99
normal! 018|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
