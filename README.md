# Lisp Fuck
Lisp Fuck is a simple brainfuck interpreter written in Common Lisp.

#Why Is That Necessary?
This provides the ability to debug your brainfuck code using Common Lisp's rich debugging environment, or integrate brainfuck into your lisp code should that be interesting to you. There are plenty of brainfuck interpreters out there, none of which work from within Common Lisp.

#Brainfuck
Brainfuck is an esoteric programming language that works on a theoretical byte tape (the Universal Turing Machine). The commands are:
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
> #f++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
"Hello World!
"
```
#How to use:
- First [ASDF](https://common-lisp.net/project/asdf/) must be installed.
- Install this clone into your ASDF load directory. The default on linux is `~/common-lisp/`:
```
me@linux:~/common-lisp$ git clone https://github.com/equwal/LispFuck.git
```
- Run your favourite Common Lisp implementation and load the :brain package:
```
> (asdf:load-system :brain)
```

If everything runs smoothly you will be ready to brainfuck. If not then please *let it be known*. So now there is the choice between the `brain:fuck` and the `#F` notation. The #F notation is more concise but does not allow any whitespace in the brainfuck code. Below they are both shown:
```
> (brain:fuck ".+[.+] Print out all the ascii characters from 0 to 255")

"�	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
```
```
> #f.+[.+] ;Note that this comment is not part of the brainfuck because of the space between it and the brainfuck code.
"�	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
```

#Debugging

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
- Make debugging more user friendly. Better documentation and some external functions to be called with `brain:function` or `brain:*variable*`

This software is licensed under the MIT free software license.
====