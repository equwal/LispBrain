;;; guix.scm --- Guix package for brain.  Build with: guix build -f guix.scm
;;; Install with: guix package -f guix.scm
(use-modules (guix packages) (guix gexp) (guix build-system asdf)
             ((guix licenses) #:prefix license:)
             (gnu packages lisp) (gnu packages lisp-xyz) (gnu packages lisp-check))

(define %source-dir (dirname (current-filename)))

(define-public sbcl-brain
  (package
    (name "sbcl-brain")
    (version "0.0.1")
    (source (local-file (string-append %source-dir "/code") "brain-checkout"
                        #:recursive? #t
                        #:select? (lambda (file stat)
                                    (not (or (string-suffix? ".fasl" file)
                                             (string-contains file "/.git"))))))
    (build-system asdf-build-system/sbcl)
    (arguments (list #:asd-systems ''("brain")))
    (inputs (list))
    (synopsis "LispFuck: a Brainfuck interpreter/debugger in Common Lisp")
    (description "LispFuck: a Brainfuck interpreter/debugger in Common Lisp.")
    (home-page "https://github.com/equwal/LispBrain")
    (license license:expat)))

(define-public cl-brain
  (sbcl-package->cl-source-package sbcl-brain))

sbcl-brain
