# Lisp Fuck
A brainfuck interpreter written in Common Lisp.
Has only been tested on SBCL on Linux. Any testing information on other systems is much appreciated.
=======
Lisp Fuck is a simple brainfuck interpreter written in Common Lisp. It has only been tested on SBCL. Any testing information on other systems is much appreciated.

#Brainfuck
Brainfuck is an esoteric programming language that works on a theoretical byte tape. The commands are:
- \> Move to the next byte right
- \< Move to the next byte left
- . Print the current byte using ASCII
- , Read a character of input into this byte
- + Increment this byte's value by one
- - Decrement this byte's value by one (that is, subtract one from this byte and set the byte to it)
- [ Start a loop. It will be skipped if the current byte is zero, and if not it will terminate at the following "]" when it is set to zero.
- ] Delimit the end of a loop. Any other character is considered a "comment" meaning it does nothing.

These can be combined into a string such as the following "Hello, world!" program:

"++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."

#How to use:
Run SBCL or another Common Lisp implementation and load the packages file:

- \> (load "[filepath]")

For example:

- \> (load "/home/myusername/brainfuck/packages.lisp")

Load up the "interpreter.lisp" file, which contains all of the code

- \> (load "/home/your_username/your_file_path/interpreter.lisp)

Use the cl-brainfuck package to get access to the public API

- \> (use-package :cl-brainfuck)

Execute some brainfuck with the interpret function:

- \> (interpret "This is some brainfuck code: +++++++++++++++++++++++++++++++++++++[->+>+<<]>.>.")

Run a string of brainfuck code with:

- \> (interpret "[code]")

For example:

- \> (interpret ".+[.+] Print out all the ascii characters and string refs")

NULLSOHSTXETXEOTENQACKBELBSHTLFVTFFCRSOSIDLEDC1DC2DC3DC4NAKSYNETBCANEMSUBESCFSGSRSUS !"#$%&'(NIL*+,-./0123456789:;<=\>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~DELÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»░▒▓│┤ÁÂÀ©╣║╗╝¢¥┐└┴┬├─┼ãÃ╚╔╩╦╠═╬¤ðÐÊËÈıÍÎÏ┘┌█▄¦Ì▀ÓßÔÒõÕµþÞÚÛÙýÝ¯´¬±‗¾¶§÷¸°¨•¹³²■nbsp

NIL

Some nonprintable ASCII characters such as START OF HEADER (ascii number one) and NULL (ascii number 0) are represented with acronyms. See the following example, which also shows the use of some comments in the brainfuck code:

- \> (interpret "+. Print a SOH -. reset and print a NULL")

SOHNULL

NIL

#TODO:

Fix the following major issues:

 - Some printable characters are represented using acronyms. Just print them instead.
 
 Minor issues:
 
 - The packaging system requires a lot of effort on the part of the user. Use ASDF instead.

Recommendations are welcome.

Minor issues:

 - Doesn't use a packaging system. Names might interfere with other packages or user-defined names.
 - Each byte is stored using the "integer" datatype and abstracted into a byte using accessor functions. It would be faster and use less space if it only took up one byte of space per theoritical byte.
 
This software is licensed under the MIT free license.
===============