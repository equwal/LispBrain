;;; The MIT License (MIT)
;;;; Copyright (c) 2016  Spenser Truex
;;;; Permission is hereby granted, free of charge, to any person obtaining a copy of this brainfuck software and associated documentation files (the "Brainfuck Software"), to deal in the Brainfuck Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Brainfuck Software, and to permit persons to whom the Brainfuck Software is furnished to do so, subject to the following conditions:

;;;; The above copyright notice and this permission notice shall be included in all copies or substantial portions of this Brainfuck Software.

;;;; THE BRAINFUCK SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THIS BRAINFUCK SOFTWARE OR THE USE OR OTHER DEALINGS IN THIS BRAINFUCK SOFTWARE.
(in-package :cl-user)
(defpackage :brain
  (:use :cl)
  (:export :fuck ;Used to execute a brainfuck string directly
	   :*tape-size-default* ;Number of cells in the tape
	   :decf-byte ;The - operator
	   :incf-byte ;The + operator
	   :read-this-byte ;The , operator
	   :print-this-byte ;The . operator
	   :right-shift ;The > operator
	   :left-shift ;The < operator
	   
	   ;;Function called to loop over each character in the code
	   :one-off-fuck
	   
	   :*separators* ;Characters that terminate #F brainfuck code
	   
	   ;; Returns the value of the current byte, most probably the one
	   ;; that the code finished executing over
	   :byte-value
	   
	   :*tape* ;contains the entire byte tape. Useful to view contents.
	   :*pointer* ;The current position in the byte tape. Useful with byte-value
	   ))
