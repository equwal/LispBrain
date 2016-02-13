# Lorrainefuck
A brainfuck interpreter written in Common Lisp.
Has only been tested on SBCL. Any testing information on other systems is much appreciated.

#Brainfuck
Brainfuck is an esoteric programming language that works on a theoretical byte tape. The commands are:
- \> Move to the next byte right
- < Move to the next byte left
- . Print the current byte using ASCII
- , Read a character of input into this byte
- + Increment this byte's value by one
- - Decrement this byte's value by one (that is, subtract one from this byte and set the byte to it)
- [ Start a loop. It will be skipped if the current byte is zero, and if not it will terminate at the following "]" when it is set to zero.
- ] Delimit the end of a loop.
any other character is considered a "comment" meaning it does nothing.
These can be combined into a string such as the following "Hello, world!" program (which currently will not work due to the nested loops implementation bug):
"++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."

#How to use:
Run SBCL or another Common Lisp implementation and load the file:
- \> (load "[filepath]")
For example:
- \> (load "/home/myusername/interpreter.lisp")
Run a string of brainfuck code with:
- \> (interpret-fuck "[code]")
For example:
- \> (interpret ".+[.+] Print out all the ascii characters and string refs")
NULLSOHSTXETXEOTENQACKBELBSHTLFVTFFCRSOSIDLEDC1DC2DC3DC4NAKSYNETBCANEMSUBESCFSGSRSUS !"#$%&'(NIL*+,-./0123456789:;<=\>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~DELÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»░▒▓│┤ÁÂÀ©╣║╗╝¢¥┐└┴┬├─┼ãÃ╚╔╩╦╠═╬¤ðÐÊËÈıÍÎÏ┘┌█▄¦Ì▀ÓßÔÒõÕµþÞÚÛÙýÝ¯´¬±‗¾¶§÷¸°¨•¹³²■nbsp

NIL

SOH is an unprintable ASCII character, which is currently represented using the literal string "SOH".
Code supports comments too:
- \> (interpret-fuck "+. Print a SOH -. reset and print a NULL")
SOH

NIL

#TODO:
Fix the following major issues:
 - Nested loops do not work. This implementation is not turing complete without them. They will be implemented soon.
 - Some printable characters are represented using literal string references
 - The internal function "one-off-fuck" needs to have a macro used to generate it, it is a mess.
