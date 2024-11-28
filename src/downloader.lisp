(defpackage #:aoc24/downloads
  (:use :cl)
  (:local-nicknames (#:u :uiop))
  (:import-from :uiop #:run-program #:directory-files #:subdirectories)
  (:export #:get-input :*session-cookie*))
(in-package #:aoc24/downloads)

(defvar *session-cookie* nil
  "The session cookie, that is used by the downloader to get the current input")

(defun get-input (day)
  (assert *session-cookie* (*session-cookie*) "The *session-cookie* variable is empty. Without it no HTTP call can be made.")
  (let* ((advent-cookie (make-instance 'drakma:cookie
                                        :name "session"
                                        :value *session-cookie*
                                        :domain ".adventofcode.com"))
         (cookie-jar (make-instance 'drakma:cookie-jar
                                    :cookies (list advent-cookie)))
         (response (drakma:http-request "https://adventofcode.com/2023/day/1/input"
                                        :cookie-jar cookie-jar)))
    response
    )
)
