# Lisp Fuck
Lisp Fuck is a simple brainfuck interpreter written in Common Lisp. It has only been tested on SBCL. Any testing information on other systems is much appreciated.

#Why Is That Necessary?
This provides the ability to debug your brainfuck code using common lisp's rich debugging environment, or integrate brainfuck into your lisp code should that be interesting to you.

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

These can be combined into a string such as the following "Hello World!" program:
```
> (interpret "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.")
"Hello World!
"
```
#How to use:
Store this project's code in the common-lisp directory under your home directory. Then it may be loaded like this:
```
> (asdf:load-system "brain")
```
The external functions need to be **used**, so execute this command.
```
> (use-package :cl-brainfuck)
or alternatively the brainfuck functions may be called using the brain:function notation:
> (brain:fuck "[Put your code in the string]")
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
;; Also:
> (brain:fuck "[This is a loop comment.]")
```
Debugging brainfuck code can be done using all the normal lisp functions `step`, `trace`, `time`, etc., but require the user to understand how the internal code works. For this reason there is no tutorial on how to properly debug your brainfuck code, just a couple examples.

Suppose you want to make the tape only 10 bytes long:
```
> (in-package :brain)
> (setf *tape-size-default* 10) ;Sets the tape to only elements 0 to 9
> (reset-globals) ;Resets the tape, pointer, and a few other things
> *tape*
10
> *pointer*
5
```
Suppose you want to find information about the + and - operations:
```
> (trace incf-byte decf-byte)
> (fuck "+-")
;;;; This text following is implementation dependent, and looks like THIS on SBCL
  0: (INCF-BYTE)
  0: INCF-BYTE returned 1
  0: (DECF-BYTE)
  0: DECF-BYTE returned 0
""
```
#TODO:
- Test on other implementations and operating systems.

This software is licensed under the MIT free software license.
====


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/equwal/lispfuck/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

