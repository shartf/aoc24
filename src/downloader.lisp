(defpackage #:aoc24/downloads
  (:use :cl)
  (:local-nicknames (#:u :uiop)		    
		    #:drakma)
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:get-input))
(in-package #:aoc24/downloads)

(defun get-input ()
  (list '(1 2 4)))

(drakma:http-request "https://adventofcode.com/2023/day/1/input") ;;zhopa
