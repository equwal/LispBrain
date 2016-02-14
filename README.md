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

These can be combined into a string such as the following "Hello World!#\Newline" program:
```
> (interpret "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")
"Hello World!
"
```
#How to use:
Store this project's code in the common-lisp directory under your home directory. Then it may be loaded like this:
```
> (asdf:load-system "lispfuck")
```
The external functions need to be **used**, so execute this command.
```
> (use-package :cl-brainfuck)
```
Your brainfuck interpreter is now loaded!

You can run a string of brainfuck code with:
```
> (interpret "[code]")
```
For example:
```
> (interpret ".+[.+] Print out all the ascii characters")

"�	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
```
Take note that the `interpret` command returns a string, which allows the brainfuck to be used within other lisp code.

Finally, there is a slightly more profane alias for the `interpret` function:
```
> (fuck "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.F+++++++++++++++.U------------------.C++++++++.K")
"FUCK"
```
#TODO:
- Test on other implementations and operating systems.
This software is licensed under the MIT free software license.
===============
