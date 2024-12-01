(defpackage #:aoc24/day2
  (:use :cl)
  (:local-nicknames (#:u :uiop)
		    (#:s :serapeum))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:download-input))
(in-package #:aoc24/day2)
