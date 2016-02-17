;;;; Copyright (c) 2016  Spenser Truex
;;;; Permission is hereby granted, free of charge, to any person obtaining a copy of this brainfuck software and associated 
;;;; documentation files (the "Brainfuck Software"), to deal in the Brainfuck Software without restriction, including without
;;;; limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the 
;;;; Brainfuck Software, and to permit persons to whom the Brainfuck Software is furnished to do so, subject to the following 
;;;; conditions:

;;;; The above copyright notice and this permission notice shall be included in all copies or substantial portions of this
;;;;Brainfuck Software.

;;;; THE BRAINFUCK SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
;;;; TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS 
;;;; OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
;;;; OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THIS BRAINFUCK SOFTWARE OR THE USE OR OTHER DEALINGS IN THIS 
;;;; BRAINFUCK SOFTWARE.
(in-package :brain)
(defconstant +close-bracket+ #\])
(defconstant +open-bracket+ #\[)
(defparameter *tape-size-default* 30000
  "The size of the tape, in bytes, used to store each byte")

(defvar *output* ""
  "Defaults to an empty string because it is setf'd by other functions")

(defparameter *initial-element* 0
  "initial value for inside the byte array")

(defparameter *separators* '(#\Newline #\Space #\))
  "#F notation separators. These can be changed to allow whitespace 
comments or to break a right parentheses immediately to the right side")

(defparameter *unread-separators* '(#\))
  "#F notation separators that should be unread for use by other functions")

(defun make-tape-array ()
  "Creates a new tape array"
  (make-array *tape-size-default*
	      :element-type '(unsigned-byte 8)
	      :initial-element *initial-element*))

(defvar *tape* (make-tape-array)
  "The tape array used to store each byte")

(defvar *brainfuck* ""
  "Place to store brainfuck code input string globally")

;; Conditions for looping 
(define-condition open-loop-at-zero (condition) ())
(define-condition end-of-loop (condition) ())

(defun pointer-default ()
  "Get the value to  set the pointer back to."
  (floor (/ *tape-size-default* 2)))

(defvar *pointer* (pointer-default)
  "The pointer location for the tape. Starts near the middle.")

(defun reset-globals ()
  (setf *tape* (make-tape-array))
  (setf *brainfuck* "")
  (setf *pointer* (pointer-default))
  (setf *output* ""))


(defvar *tape* (make-tape-array)
  "The tape array used to store each byte")

(defvar *brainfuck* ""
  "Place to store brainfuck code input string globally")

(defun any-char (char sequence)
  "Compare the 'char' to each element of 'sequence' using the 'some'
command"
  (some #'(lambda (x) (char-equal x char))
	sequence))

(defun char-list->string-aux (char-list string position)
  (if (null (first char-list))
      string
      (char-list->string-aux (rest char-list)
			     (progn (setf (char string position)
					  (first char-list))
				    string)
			     (1+ position))))
(defun char-list->string (char-list)
  (char-list->string-aux char-list (make-string (length char-list)) 0))

(defun shorthand-fuck-aux (stream list)
  "Recursive reader macro. A compiler from within Lisp!"
  (let ((char (read-char stream nil nil)))
    (if (or (any-char char *separators*)
	    (null char))
	(progn (when (any-char char *unread-separators*)
		 (unread-char char stream))
	       (char-list->string (nreverse list)))
	(shorthand-fuck-aux stream (push char list)))))

(defun shorthand-fuck (stream char subchar)
  "This is a 'Reader Macro' that provides the #F notation"
  (declare (ignore char subchar))
  (list 'fuck (shorthand-fuck-aux stream nil)))
(set-dispatch-macro-character #\# #\F #'shorthand-fuck)

(defun wrap-pointer ()
  (cond ((= *pointer* *tape-size-default*) (setf *pointer* 0))
		((= *pointer* -1) (setf *pointer* (1- *tape-size-default*)))))
(defmacro byte-value ()
  `(aref *tape* *pointer*))

(defun remove-first (string)
  (if (= 1 (length string))
      ""
      (subseq string 1)))

(defmacro crement-if (operation
		      bound
		      bound-next)
  "Increment or decrement a byte"
  `(if (= (byte-value) ,bound)
      (setf (byte-value) ,bound-next)
      (,operation (byte-value))))

(defun incf-byte ()
  "Increment a byte, and wrap to 0 if 255 is incremented"
  (crement-if incf 255 0))

(defun decf-byte ()
  "Decrement a byte, and wrap to 255 if 0 is decremented"
  (crement-if decf 0 255))

(defun first-elt (string)
  (elt string 0))

(defun ascii->integer (char)
  (char-code char))

(defun integer->ascii (num)
  (code-char num))

(defun goto-aux (current-position
		 depth)
  (let ((this (elt *brainfuck* current-position)))
    (if (char= +open-bracket+ this)
	(if (= 1 depth)
	    current-position
	    (if (> depth 1)
		(goto-aux (1- current-position)
			  (1- depth))
		(goto-aux (1- current-position)
			  0)))
	(if (char= +close-bracket+ this)
	    (goto-aux (1- current-position)
		      (1+ depth))
	    (goto-aux (1- current-position)
		      depth)))))
(defun goto (position)
  "Work backwards and find the matching open bracket."
  (goto-aux position 0))

(defun right-shift ()
  "Move to the next byte to the 'right'"
  (incf *pointer*)
  (wrap-pointer))

(defun left-shift ()
  "Move to the next byte to the 'left'"
  (decf *pointer*)
  (wrap-pointer))

(defun print-this-byte ()
  (setf *output* (concatenate 'string
			      *output*
			      (vector (integer->ascii (byte-value))))))

(defun read-this-byte ()
  (setf (byte-value)
	(ascii->integer (read-char))))

(defun one-off-fuck (position)
  "Run a single first brainfuck-char."
  (case (elt *brainfuck* position)
    (#\, (read-this-byte))
    (#\. (print-this-byte))
    (#\+ (incf-byte))
    (#\- (decf-byte))
    (#\] (error 'end-of-loop))
    (#\[ (if (= 0 (byte-value))
	     (error 'open-loop-at-zero)))
    (#\> (right-shift))
    (#\< (left-shift))))

(defun skip-loop-aux (position depth)
  (let ((this (char *brainfuck* position)))
    (if (char= +open-bracket+ this)
	(skip-loop-aux (1+ position) (1+ depth))
	(if (char= +close-bracket+ this)
	    (if (= 1 depth)
		(1+ position)
		(skip-loop-aux (1+ position) (1- depth)))
	    (skip-loop-aux (1+ position) depth)))))

(defun skip-loop (position)
  (skip-loop-aux position 0))

(defun fuck (brainfuck-string)
  "Interpret the brainfuck"
  (reset-globals)
  (setf *brainfuck* brainfuck-string)
  ;; Loop over each character in the string
  (loop for position to (1- (length *brainfuck*))
     do (handler-case (one-off-fuck position)
	  ;; Handles looping with the condition system
	  (end-of-loop () (setf position
				(1- (goto position))))
	  (open-loop-at-zero () (setf position
				      (1- (skip-loop position))))))
  *output*)
