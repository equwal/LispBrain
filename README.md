# Lisp Fuck
Lisp Fuck is a simple brainfuck interpreter written in Common Lisp. It comes with the best debugging environment for brainfuck there is by using Common Lisp to run it.

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
#How to install:
- First [ASDF](https://common-lisp.net/project/asdf/) must be installed.
- Install this clone into your ASDF load directory. The default on linux is `~/common-lisp/`:
```
me@linux:~/common-lisp$ git clone https://github.com/equwal/LispFuck.git
```
- Run your favourite Common Lisp implementation and load the :brain package:
```
> (asdf:load-system :brain)
```

If everything runs smoothly you will be ready to brainfuck. If there are issues then please *let it be known*. Now there is the choice between the `brain:fuck` and the `#F` notation. The `#F` notation is more concise but does not allow any whitespace in the brainfuck code, while the `brain:fuck` notation allows any character except for an unescaped literal quote `"` inside of the brainfuck code. Below they are both shown:
```
> (brain:fuck ".+[.+] Print out all the ascii characters from 0 to 255")

"�	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
```
```
> #f.+[.+] This text is not inside the brainfuck code. <>,.+-[] has no effect on it
"�	

 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
```

#Debugging Brainfuck

Debugging brainfuck code can be done using all the normal Common Lisp functions: `step`, `trace`, `time`, etc. The following functions and variables are exported to the user and may be useful for debugging brainfuck code:
```
brain:fuck ;Used to execute a brainfuck string directly
brain:*tape-size-default* ;Number of cells in the tape Default: 30,000
brain:decf-byte ;The - operator function
brain:incf-byte ;The + operator function
brain:read-this-byte ;The , operator function
brain:print-this-byte ;The . operator function
brain:right-shift ;The > operator function
brain:left-shift ;The < operator function
brain:one-off-fuck ;Function called to loop over each character in the code
brain:*separators* ;Characters that terminate #F brainfuck code Default: (#\Space, #\Newline)
brain:byte-value ;Returns the value of the curren byte at the *pointer* position
brain:*tape* ;Returns the entire tape
brain:*pointer* ;The current position in the byte tape. Useful with byte-value Default: Exactly in the middle of the tape. (15,000)
```
Note that the variables `*tape*` and `*pointer*` are reset upon executing new brainfuck code. Once the execution is finished their state is frozen in time and ready to be debugged.

#Examples for Debugging:
Suppose you want to make the tape only 10 bytes long (instead of the default 30000) This way you can easily view the tape contents after execution:
```
> (setf brain:*tape-size-default* 10) ;Sets the tape to only elements 0 to 9
> #f->+
> brain:*tape* ;Holds the byte tape vector
#(0 0 0 0 0 255 1 0 0 0)
> brain:*pointer*
6
```
Suppose you want to find information about how often and with what values + and - were used:
```
> (trace brain:incf-byte brain:decf-byte)
> (brain:fuck "+-")
;;;; The following text is implementation dependent, and looks exactly like this only on SBCL
  0: (INCF-BYTE)
  0: INCF-BYTE returned 1
  0: (DECF-BYTE)
  0: DECF-BYTE returned 0
""
```
This software is licensed under the MIT free software license.
====