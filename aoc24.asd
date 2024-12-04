(in-package :asdf)

(asdf:defsystem #:aoc24
  :long-name "advent-of-code-24-cl"
  :version "0.0.1"
  :author "SH"
  :license "MIT"
  :depends-on (:alexandria
	       :uiop
	       :drakma
	       :serapeum)
  :components ((:module "src"
		:components
		(
		 (:file "downloader")
		 (:file "main" :depends-on ("downloader"))
		 (:file "day1")		 
		 (:file "day2")
		 (:file "day3")
		 )))
  :description "Advent of Code 24"
  :long-description "Advent of Code 24 in Common Lisp"
  :in-order-to ((test-op (test-op :aoc24/test)))
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

