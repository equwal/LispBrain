# Lisp Fuck
Lisp Fuck is a simple brainfuck interpreter written in Common Lisp. It has only been tested on SBCL. Any testing information on other systems is much appreciated.

#Brainfuck
Brainfuck is an esoteric programming language that works on a theoretical byte tape. The commands are:
```
> Move to the next byte right
< Move to the next byte left
. Print the current byte using ASCII
, Read a character of input into this byte
+ Increment this byte's value by one
- Decrement this byte's value by one (that is, subtract one from this byte and set the byte to it)
[ Start a loop. It will be skipped if the current byte is zero, and if not it will terminate at the following "]" when the cell is finally set to zero.
] Delimit the end of a loop. 
Any other character is considered a "comment" meaning it does nothing.
```

These can be combined into a string such as the following "Hello, world!" program:
```
(interpret "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")
```
#How to use:
Run SBCL or another Common Lisp implementation and load the packages file:
```
> (load "[filepath]")
```
For example:
```
> (load "/home/myusername/brainfuck/packages.lisp")
```
Load up the "interpreter.lisp" file, which contains all of the code
```
> (load "/home/your_username/your_file_path/interpreter.lisp)
```
**Use** the cl-brainfuck package to get access to the public API
```
> (use-package :cl-brainfuck)
```
Run a string of brainfuck code with:
```
> (interpret "[code]")
```
Another example:
```
> (interpret ".+[.+] Print out all the ascii characters")

�	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ

NIL ;note that NIL will always be returned by (interpret). The above text is written to *standard-output*
```
#TODO:
 - ASDF would be a better packaging system choice than the current arrangement.
 
This software is licensed under the MIT free software license.
===============
