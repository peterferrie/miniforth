: >in a02 ;
: run >in ! ;
swap : dp 0 [ dup @ 2 - ! ] ;
: here dp @ ;
: cell+ 2 + ;
: cells dup + ;
: +! dup >r @ + r> ! ;
: allot dp +! ;
: c, here c! 1 allot ;
: , here ! 2 allot ;
: 'lit 0 [ here 4 - @ here 2 - ! ] ;
: lit, 'lit , , ;
: disk# [ lit, ] ;
: base [ lit, ] ;
: st [ lit, ] ;
: latest [ lit, ] ;
: [[ 1 st c! ;
here 2 - @ : 'exit [ lit, ] ;
: constant : [[ lit, 'exit , ;
: create : [[ here 3 cells + lit, 'exit , ;
: variable create 1 cells allot ;
variable checkpoint
variable srcpos
: s+ srcpos @ s: dup u. srcpos ! ;
: move-checkpoint srcpos @ checkpoint ! ;
: doit checkpoint @ run move-checkpoint ;
: ax 0 ; : cx 1 ; : dx 2 ; : bx 3 ; : sp 4 ; : bp 5 ; : si 6 ; : di 7 ;
: al 0 ; : cl 1 ; : dl 2 ; : bl 3 ; : ah 4 ; : ch 5 ; : dh 6 ; : bh 7 ;
: :code : [[ here 3 - dp ! ;
: stosb, aa c, ; : stosw, ab c, ; : lodsb, ac c, ; : lodsw, ad c, ;
: 2* dup + ;
: 3shl 2* 2* 2* ;
: rm-r, 3shl + c0 + c, ;
: jmp-r, ff c, 4 rm-r, ;
: next, lodsw, ax jmp-r, ;
: movw-rr, 8b c, rm-r, ;
: push, 50 + c, ;
