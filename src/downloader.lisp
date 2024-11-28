(defpackage #:aoc24/downloads
  (:use :cl)
  (:local-nicknames (#:u :uiop)
                    )
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:get-input))
(in-package #:aoc24/downloads)

(defun get-input ()
  (list '(1 2 4)))
