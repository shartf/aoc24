
(in-package :asdf)

(asdf:defsystem #:cl-dop
  :long-name "advent-of-code-24-cl"
  :version "0.0.1"
  :author "SH"
  :license "MIT"
  :depends-on (:alexandria
               :uiop
               :)
  :components ((:module "src"
                :components
                (
                 (:file "main" :depends-on ("downloader")
                 (:file "downloader"))))
  :description "Advent of Code 24"
  :long-description "Advent of Code 24 in Common Lisp"
  ;:in-order-to ((test-op (test-op :cl-dop/test)))
  )

; (asdf:defsystem #:cl-dop/test
;   :author "SH"
;   :license "MIT"
;   :depends-on (:cl-dop :fiveam)
;   :components ((:module "test"
; 		:components
; 		((:file "jsonparser")
; 		 (:file "main"))))
;   :description "Test system for cl-dop"
;   :perform (test-op (o c)
; 		    (symbol-call :fiveam :run!
; 				 (find-symbol* :cl-dop :cl-dop/test)))
;   )
