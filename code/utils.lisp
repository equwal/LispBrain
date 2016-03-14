(in-package :brain)

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

(defun first-elt (string)
  (elt string 0))

(defun ascii->integer (char)
  (char-code char))

(defun integer->ascii (num)
  (code-char num))

(defun remove-first (string)
  (if (= 1 (length string))
      ""
      (subseq string 1)))
