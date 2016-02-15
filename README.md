# Lisp Fuck
Lisp Fuck is a simple brainfuck interpreter written in Common Lisp.

#Why Is That Necessary?
This provides the ability to debug your brainfuck code using Common Lisp's rich debugging environment, or integrate brainfuck into your lisp code should that be interesting to you. There are plenty of brainfuck interpreters out there, none of which work from within common lisp.

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
Store this project's code in the ASDF load directory; [ASDF](https://common-lisp.net/project/asdf/) must be installed. Then it may be loaded like this:
```
> (asdf:load-system "brain")
```
The external functions are easier to use when they have been *used*, so execute this command.
```
> (use-package :brain)
or alternatively the brainfuck functions may be called using the brain:[function] notation, without being used:
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
Debugging brainfuck code can be done using all the normal Common Lisp functions: `step`, `trace`, `time`, etc., but require the user to understand how the internal code works. For this reason there is no tutorial on how to properly debug your brainfuck code, just a couple examples. The user is encouraged to read the Common Lisp source code to get all the features of the Lisp debugging environment in their brainfuck.

To debug your brainfuck code you should start with:
```
> (in-package :brain)
```
to get access to the internal functions.

Suppose you want to make the tape only 10 bytes long (instead of the default 30000):
```
> (in-package :brain)
> (setf *tape-size-default* 10) ;Sets the tape to only elements 0 to 9
> (reset-globals) ;Resets the tape, pointer, and a few other things
> *tape* ;Holds the byte tape vector
#(0 0 0 0 0 0 0 0 0 0)
> *pointer* ;This shows that the pointer gets moved to the middle regardless of the size
5
```
Suppose you want to find information about the + and - operations:
```
> (trace incf-byte decf-byte)
> (fuck "+-")
;;;; The following text is implementation dependent, and looks like this only on SBCL
  0: (INCF-BYTE)
  0: INCF-BYTE returned 1
  0: (DECF-BYTE)
  0: DECF-BYTE returned 0
""
```
#TODO:
- Test on other implementations and operating systems (CCL, ECL, ABCL, CLISP, AllegroCL, LispWorks), to verify that it works.
- Make debugging more user friendly.
- `#F` reader macro (Ex: `#F.+[.+]` instead of `(fuck ".+[.+]")`

This software is licensed under the MIT free software license.
====

