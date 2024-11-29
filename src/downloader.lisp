(defpackage #:aoc24/downloads
  (:use :cl)
  (:local-nicknames (#:u :uiop))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:download-input))
(in-package #:aoc24/downloads)

(defparameter *session-cookie* (u:read-file-line "session.txt"))
(setf drakma:*header-stream* *standard-output*) ;; need it be able to see the calls

(declaim (ftype (function (string)) download-input))
(defun download-input (day)
  "Entry point for the downloader. Will take in an day as a number and check for existing file.
If file exists, it will do nothing, if not it will download and create it."
  (let* ((path-string (concatenate 'string "input/" day ".txt"))
	 (path-pathname (asdf:system-relative-pathname "aoc24" path-string)))
    (when (not (probe-file path-pathname))
      (let ((input-text (get-input-from-remote day)))
	(write-file input-text path-pathname)))))

(declaim (ftype (function (string pathname)) write-file))
(defun write-file (input-text path-pathname)
  "Writes text to a file."
  (with-open-file (text-to-write path-pathname
				 :direction :output
				 :if-exists nil
				 :if-does-not-exist :create)
    (format text-to-write input-text)))

(declaim (ftype (function (string)) get-input-from-remote))
(defun get-input-from-remote (day)
  "Gets input from AOC. Returns text."
  (assert *session-cookie* (*session-cookie*) "The *session-cookie* variable is empty. Without it no HTTP call can be made.")
  (let* ((advent-cookie (make-instance 'drakma:cookie
				       :name "session"
				       :value *session-cookie*
				       :domain ".adventofcode.com"))
         (cookie-jar (make-instance 'drakma:cookie-jar
                                    :cookies (list advent-cookie))))
    (drakma:http-request (concatenate 'string "https://adventofcode.com/2024/day/" day "/input")
			 :cookie-jar cookie-jar)))



